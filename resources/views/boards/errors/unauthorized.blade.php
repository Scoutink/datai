@extends('layouts.boards')

@section('title', 'Access Denied')

@section('content')
<div class="boards-error-container">
    <div class="boards-error-card">
        <div class="boards-error-icon">
            <i class="fa fa-exclamation-triangle"></i>
        </div>
        <h1 class="boards-error-title">Access Denied</h1>
        <p class="boards-error-message">{{ $message ?? 'You do not have permission to access this resource.' }}</p>
        <div class="boards-error-actions">
            <a href="{{ route('boards.index') }}" class="boards-btn boards-btn-outline">
                <i class="fa fa-arrow-left"></i>
                Back to Boards
            </a>
            <a href="/" class="boards-btn boards-btn-primary">
                <i class="fa fa-home"></i>
                Go to Dashboard
            </a>
        </div>
    </div>
</div>
@endsection
