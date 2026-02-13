<?php

namespace App\Services\Papers;

class PaperContentService
{
    /**
     * Convert Editor.js JSON to Sanitized HTML
     */
    public function jsonToHtml($jsonContent)
    {
        if (is_string($jsonContent)) {
            $jsonContent = json_decode($jsonContent, true);
        }

        if (!isset($jsonContent['blocks'])) {
            return '';
        }

        $html = '';
        foreach ($jsonContent['blocks'] as $block) {
            switch ($block['type']) {
                case 'paragraph':
                    $html .= '<p>' . ($block['data']['text'] ?? '') . '</p>';
                    break;
                case 'header':
                    $level = $block['data']['level'] ?? 1;
                    $html .= "<h{$level}>" . ($block['data']['text'] ?? '') . "</h{$level}>";
                    break;
                case 'list':
                    $tag = ($block['data']['style'] === 'ordered') ? 'ol' : 'ul';
                    $html .= "<{$tag}>";
                    foreach ($block['data']['items'] as $item) {
                        $html .= "<li>{$item}</li>";
                    }
                    $html .= "</{$tag}>";
                    break;
                case 'checklist':
                    $html .= '<ul class="checklist">';
                    foreach ($block['data']['items'] as $item) {
                        $checked = $item['checked'] ? 'checked' : '';
                        $html .= "<li><input type='checkbox' disabled {$checked}> {$item['text']}</li>";
                    }
                    $html .= '</ul>';
                    break;
                case 'image':
                    $url = $block['data']['file']['url'] ?? '';
                    $caption = $block['data']['caption'] ?? '';
                    $html .= "<figure><img src='{$url}' alt='{$caption}'><figcaption>{$caption}</figcaption></figure>";
                    break;
                case 'quote':
                    $text = $block['data']['text'] ?? '';
                    $caption = $block['data']['caption'] ?? '';
                    $html .= "<blockquote>{$text} <footer>{$caption}</footer></blockquote>";
                    break;
                case 'delimiter':
                    $html .= '<hr>';
                    break;
                case 'table':
                    $html .= '<table>';
                    foreach ($block['data']['content'] as $row) {
                        $html .= '<tr>';
                        foreach ($row as $cell) {
                            $html .= "<td>{$cell}</td>";
                        }
                        $html .= '</tr>';
                    }
                    $html .= '</table>';
                    break;
                case 'code':
                    $code = htmlspecialchars($block['data']['code'] ?? '');
                    $html .= "<pre><code>{$code}</code></pre>";
                    break;
                case 'warning':
                    $title = $block['data']['title'] ?? '';
                    $message = $block['data']['message'] ?? '';
                    $html .= "<div class='warning'><strong>{$title}</strong><p>{$message}</p></div>";
                    break;
            }
        }

        return $this->sanitizeHtml($html);
    }

    /**
     * Sanitize HTML to prevent XSS
     */
    public function sanitizeHtml($html)
    {
        $allowedTags = '<p><b><i><u><a><h1><h2><h3><h4><h5><h6><ul><ol><li><blockquote><pre><code><br><hr><img><table><thead><tbody><tr><th><td><div><span><figure><figcaption><strong><em>';
        return strip_tags($html, $allowedTags);
    }

    /**
     * Extract plain text for indexing
     */
    public function extractPlainText($jsonContent)
    {
        if (is_string($jsonContent)) {
            $jsonContent = json_decode($jsonContent, true);
        }

        if (!isset($jsonContent['blocks'])) {
            return '';
        }

        $text = '';
        foreach ($jsonContent['blocks'] as $block) {
            $blockText = '';
            if (isset($block['data']['text'])) {
                $blockText = $block['data']['text'];
            } elseif (isset($block['data']['items'])) {
                // For lists and checklists
                foreach ($block['data']['items'] as $item) {
                    $blockText .= (is_array($item) ? ($item['text'] ?? '') : $item) . ' ';
                }
            } elseif (isset($block['data']['content'])) {
                // For tables
                foreach ($block['data']['content'] as $row) {
                    foreach ($row as $cell) {
                        $blockText .= $cell . ' ';
                    }
                }
            } elseif (isset($block['data']['caption'])) {
                $blockText = $block['data']['caption'];
            }

            $text .= strip_tags($blockText) . ' ';
        }

        return trim($text);
    }

    /**
     * Calculate word count
     */
    public function calculateWordCount($text)
    {
        return str_word_count($text);
    }

    /**
     * Calculate reading time in minutes
     */
    public function calculateReadingTime($wordCount)
    {
        $wordsPerMinute = 200;
        return (int) ceil($wordCount / $wordsPerMinute);
    }
}
