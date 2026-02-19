<?php

namespace App\Services\Papers;

use App\Models\PaperAssets;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class PaperAssetService
{
    /**
     * SSRF Protection: Validate URL and resolve IP
     */
    public function validateUrl($url)
    {
        $parts = parse_url($url);
        if (!$parts || !in_array($parts['scheme'], ['http', 'https'])) {
            return false;
        }

        $host = $parts['host'];
        $ip = gethostbyname($host);

        // Check against private/loopback/reserved IP ranges
        if ($this->isPrivateIp($ip)) {
            return false;
        }

        return $ip;
    }

    private function isPrivateIp($ip)
    {
        $pri_addrs = [
            '10.0.0.0|10.255.255.255',     // RFC 1918
            '172.16.0.0|172.31.255.255',   // RFC 1918
            '192.168.0.0|192.168.255.255', // RFC 1918
            '169.254.0.0|169.254.255.255', // RFC 3927 (Link-local)
            '127.0.0.0|127.255.255.255',   // RFC 1122 (Loopback)
            '0.0.0.0|0.255.255.255',       // RFC 1122 (Current network)
            '100.64.0.0|100.127.255.255',  // RFC 6598 (Shared address space)
            '192.0.0.0|192.0.0.255',       // RFC 6890 (IETF protocol assignments)
            '192.0.2.0|192.0.2.255',       // RFC 5737 (TEST-NET-1)
            '198.18.0.0|198.19.255.255',   // RFC 2544 (Benchmarking)
            '198.51.100.0|198.51.100.255', // RFC 5737 (TEST-NET-2)
            '203.0.113.0|203.0.113.255',   // RFC 5737 (TEST-NET-3)
            '224.0.0.0|239.255.255.255',   // RFC 3171 (Multicast)
            '240.0.0.0|255.255.255.254',   // RFC 1112 (Reserved)
            '::1',                         // IPv6 Loopback
            'fc00::',                      // IPv6 Unique local
            'fe80::',                      // IPv6 Link-local
        ];

        $long_ip = ip2long($ip);
        if ($long_ip === false) {
             // Handle IPv6 or invalid
             return $ip === '::1' || str_starts_with($ip, 'fe80') || str_starts_with($ip, 'fc00');
        }

        foreach ($pri_addrs as $pri_addr) {
            if (str_contains($pri_addr, '|')) {
                list($start, $end) = explode('|', $pri_addr);
                if ($long_ip >= ip2long($start) && $long_ip <= ip2long($end)) return true;
            }
        }

        return false;
    }

    /**
     * Fetch Link Metadata for Editor.js Link Tool
     */
    public function fetchLinkMeta($url)
    {
        if (!$this->validateUrl($url)) {
            return ['success' => 0];
        }

        try {
            $response = Http::timeout(5)->get($url);
            if (!$response->successful()) return ['success' => 0];

            $html = $response->body();
            $meta = [
                'success' => 1,
                'meta' => [
                    'title' => $this->getMetaTag($html, 'title') ?: $this->getTagName($html, 'title'),
                    'description' => $this->getMetaTag($html, 'description'),
                    'image' => ['url' => $this->getMetaTag($html, 'og:image')]
                ]
            ];
            return $meta;
        } catch (\Exception $e) {
            return ['success' => 0];
        }
    }

    private function getMetaTag($html, $name)
    {
        preg_match('/<meta[^>]+(?:name|property)=["\']' . preg_quote($name, '/') . '["\'][^>]+content=["\']([^"\']+)["\']/i', $html, $matches);
        return $matches[1] ?? null;
    }

    private function getTagName($html, $tag)
    {
        preg_match('/<' . $tag . '[^>]*>(.*?)<\/' . $tag . '>/is', $html, $matches);
        return $matches[1] ?? null;
    }

    /**
     * Store Image for Editor.js Image Tool
     */
    public function storeImage($paperId, $file)
    {
        $path = $file->store('papers/assets', 'public');
        
        $asset = PaperAssets::create([
            'paperId' => $paperId,
            'type' => 'image',
            'storageDisk' => 'public',
            'path' => $path,
            'originalName' => $file->getClientOriginalName(),
            'mime' => $file->getMimeType(),
            'size' => $file->getSize(),
            'createdBy' => Auth::id()
        ]);

        return [
            'success' => 1,
            'file' => [
                'url' => Storage::disk('public')->url($path),
                'assetId' => $asset->id
            ]
        ];
    }
}
