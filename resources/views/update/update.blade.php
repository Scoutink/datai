@extends('update.update-layout')

@section('content')

<div class="sm:mx-auto sm:w-full sm:max-w-md">
    @if (file_exists(public_path('logo.png')))
    <div class="text-center">
        <img src="{{ asset('logo.png') }}" alt="{{ config('app.name') }}" style="width: 50%;height: auto;border-radius: 10px;" class="mx-auto h-12 w-auto">
    </div>
    @endif
</div>


@if(session('taskStatus'))
<div class="panel">
    <h3 class="{{ session('taskStatus.type') === 'success' ? 'text-success-500' : '' }}">{{ session('taskStatus.message') }}</h3>
    @if(!empty(session('taskStatus.output')))
    <pre style="text-align:left;white-space:pre-wrap;background:#f8f8f8;padding:12px;border-radius:6px;">{{ session('taskStatus.output') }}</pre>
    @endif
</div>
@endif

<div class="panel">
    <h3>Plesk One-Click Maintenance</h3>
    <p>If you don't use SSH, you can run required backend tasks from here.</p>

    <div style="display:flex;justify-content:center;gap:12px;flex-wrap:wrap;">
        <form action="{{ url('update/tasks/migrate') }}" method="post" style="margin:0;">
            {{ csrf_field() }}
            <button class="button bg-primary-600" type="submit">Run Database Migration</button>
        </form>

        <form action="{{ url('update/tasks/clear-cache') }}" method="post" style="margin:0;">
            {{ csrf_field() }}
            <button class="button bg-primary-600" type="submit">Clear/Refresh Cache</button>
        </form>
    </div>

    <p style="margin-top:15px;text-align:left;">
        Frontend build (<code>npm run build</code>) still requires Node.js/Angular CLI installed on the server. If Plesk has Node enabled for this app, that build can be added as another button.
    </p>
</div>

@if(!$isUpdateAvailable)
<div class="panel">
    <h3 class="text-success-500">Great news! No update available at this time. Your system is up-to-date and running smoothly.</h3>

    <div class="-m-7 mt-6 rounded-b border-t border-neutral-200 bg-neutral-50 p-4 text-center">
        <a href="{{ url('login') }}" rel="noopener noreferrer" class="inline-flex items-center rounded-md border border-transparent bg-primary-600 px-4 py-2 text-sm text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 hover:bg-primary-700">
            Login to Continue
        </a>
    </div>
</div>
@endif

@if($isRequirementsErrors)
<div class="panel">
    <h3>Detected the following problems. Please correct them before proceeding with the update.</h3>
    <ul class="errors">
        @foreach($requirements as $req)
        @if(!$req['result'])
        <li>{{$req['errorMessage']}}</li>
        @endif
        @endforeach
    </ul>
</div>
@endif

@if($isUpdateAvailable)
<form class="panel" action="update/run" method="post">
    {{ csrf_field() }}
    <p class="text-success-500">Exciting news! A new update is available for your system. Stay ahead with the latest features, improvements, and enhancements by updating now.</p>
    <p>This might take several minutes, please don't close this browser tab while update is in progress.</p>
    @if($isRequirementsErrors)
    <button class="button bg-primary-600" type="submit" disabled>Update Now</button>
    @else
    <button class="button bg-primary-600" type="submit">Update Now</button>
    @endif
</form>
@endif
@endsection