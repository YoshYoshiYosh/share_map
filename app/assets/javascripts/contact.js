async function sendContactMessage() {
  let opinionText = document.querySelector('.opinion-text').value;

  const token = document.getElementsByName('csrf-token').item(0).content;

  const formData = new FormData();
  formData.append('authenticity_token', token);
  formData.append("contact", opinionText);

  // 開発環境と本番環境のどちらでも稼働させるために記載(環境によってPOST先を変更する必要があるため)
  let tmpVariableProtocol = /^https/.test(location.href) ? "https://" : "http://";
  
  const postRequest = await fetch(tmpVariableProtocol + location.host + '/contact', {
    method: "POST",
    body: formData,
  });

  if (postRequest.status === 200) {
    console.log('成功');
    setFlash("success");
  } else {
    console.log('失敗');
    console.log(postRequest.status);
    setFlash("danger");
  };

  setTimeout(() => {
    const flashElement = document.querySelector('.alert');
    flashElement.parentNode.removeChild(flashElement);
  }, 5000);

}

document.addEventListener("turbolinks:load", async () => {
  let sendOpinionButton = document.getElementById('send-opinion');
  sendOpinionButton.addEventListener('click', sendContactMessage);

});