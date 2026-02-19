<!DOCTYPE html>
<html lang="{{ $currentLang ?? 'en' }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="robots" content="noindex">
    
    <title>@yield('title', 'Boards') - {{ $companyProfile->title ?? 'Datai' }}</title>
    
    {{-- Favicon --}}
    @if(file_exists(public_path('logo.png')))
        <link rel="icon" href="{{ asset('logo.png') }}" type="image/png">
    @endif
    
    {{-- Core Styles --}}
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    
    {{-- Boards Custom Styles --}}
    <link href="{{ asset('css/boards.css') }}" rel="stylesheet">
    
    @stack('styles')
</head>
<body class="boards-app">
    {{-- Top Navigation --}}
    <nav class="boards-navbar">
        <div class="boards-navbar-brand">
            @if(file_exists(public_path('logo.png')))
                <img src="{{ asset('logo.png') }}" alt="{{ $companyProfile->title ?? 'Datai' }}" class="boards-logo">
            @endif
            <a href="{{ route('boards.index') }}" class="boards-brand-text">
                <span class="brand-primary">{{ $companyProfile->title ?? 'Datai' }}</span>
                <span class="brand-secondary">Boards</span>
            </a>
        </div>
        
        <div class="boards-navbar-actions">
            {{-- Language Selector --}}
            @if(isset($languages) && count($languages) > 1)
            <div class="boards-dropdown">
                <button class="boards-btn boards-btn-ghost boards-dropdown-toggle">
                    <i class="fa fa-globe"></i>
                    <span>{{ strtoupper($currentLang ?? 'EN') }}</span>
                </button>
                <div class="boards-dropdown-menu">
                    @foreach($languages as $lang)
                        <a href="?lang={{ $lang->code }}" class="boards-dropdown-item {{ ($currentLang ?? 'en') == $lang->code ? 'active' : '' }}">
                            {{ $lang->name }}
                        </a>
                    @endforeach
                </div>
            </div>
            @endif
            
            {{-- Back to Dashboard --}}
            <a href="/" class="boards-btn boards-btn-outline">
                <i class="fa fa-arrow-left"></i>
                <span>Back to Dashboard</span>
            </a>
            
            {{-- User Menu --}}
            <div class="boards-dropdown">
                <button class="boards-user-btn boards-dropdown-toggle">
                    @if(isset($user->profilePhoto) && $user->profilePhoto)
                        <img src="{{ asset('uploads/photos/' . $user->profilePhoto) }}" alt="Profile" class="boards-user-avatar">
                    @else
                        <div class="boards-user-avatar-placeholder">
                            {{ strtoupper(substr($user->firstName ?? 'U', 0, 1)) }}
                        </div>
                    @endif
                    <span class="boards-user-name">{{ ($user->firstName ?? '') . ' ' . ($user->lastName ?? '') }}</span>
                </button>
                <div class="boards-dropdown-menu boards-dropdown-menu-right">
                    <div class="boards-dropdown-header">
                        <div class="boards-user-email">{{ $user->email ?? '' }}</div>
                    </div>
                    <div class="boards-dropdown-divider"></div>
                    <a href="/" class="boards-dropdown-item">
                        <i class="fa fa-home"></i> Dashboard
                    </a>
                    <a href="/login" class="boards-dropdown-item text-danger">
                        <i class="fa fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>
    
    {{-- Alert Messages --}}
    @if(session('success'))
        <div class="boards-alert boards-alert-success">
            <i class="fa fa-check-circle"></i>
            {{ session('success') }}
            <button class="boards-alert-close">&times;</button>
        </div>
    @endif
    
    @if(session('error'))
        <div class="boards-alert boards-alert-danger">
            <i class="fa fa-exclamation-circle"></i>
            {{ session('error') }}
            <button class="boards-alert-close">&times;</button>
        </div>
    @endif
    
    {{-- Main Content --}}
    <main class="boards-main">
        @yield('content')
    </main>
    
    {{-- Footer --}}
    <footer class="boards-footer">
        <p>&copy; {{ date('Y') }} {{ $companyProfile->title ?? 'Datai' }}. All rights reserved.</p>
    </footer>
    
    {{-- Core Scripts --}}
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    
    {{-- Boards Core JS --}}
    <script src="{{ asset('js/boards.js') }}"></script>
    
    {{-- Initialize with auth token --}}
    <script>
        window.BoardsConfig = {
            csrfToken: '{{ csrf_token() }}',
            authToken: '{{ $authToken ?? "" }}',
            baseUrl: '{{ url("/") }}',
            apiUrl: '{{ url("/api") }}',
            userId: '{{ $user->id ?? "" }}'
        };
    </script>
    
    @stack('scripts')
</body>
</html>
