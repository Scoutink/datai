/* 
 *
 * @Project        
 * @Copyright      Djoudi
 * @Created        2018-02-20
 * @Filename       laravel-h5p-editor.js
 * @Description    
 *
 */
(function ($) {

    // Setting for inside editor
    // MODIFIED FOR ANGULAR SPA: Use Bearer token instead of CSRF
    var token = localStorage.getItem('token') || '';
    $.ajaxSetup({
        headers: {
            'Authorization': 'Bearer ' + token
        },
        dataType: 'json',
    });

})(H5P.jQuery);
