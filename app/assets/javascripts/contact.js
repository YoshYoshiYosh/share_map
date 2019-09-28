async function sendContactMessage() {
  let opinionText = document.querySelector('.opinion-text').value;

  const token = document.getElementsByName('csrf-token').item(0).content;

  const formData = new FormData();
  formData.append('authenticity_token', token);
  formData.append("contact", opinionText);

  const postRequest = await fetch('http://' + location.host + '/contact', {
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