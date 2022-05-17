(function () {

  document.cookie = "destination_url=" + window.location.href + ";path=/";
  let url = window.location.href;
  let split_url = url.split('/w/');
  window.location.replace(split_url[0] + "/auth/saml/?origin=" + url);
})();
