const check_file_selected = () => {
  console.log("alive!");
  const upload = document.querySelector('#cocktail_photo');
  upload.addEventListener('change', (event) => {
    const fileName = upload.value.match(/[^\\]*\.(jpg|png|gif|tif)/i)[0];
    const fileNameDiv = document.querySelector('#fileNameDiv');
    fileNameDiv.innerHTML = `✅ ${fileName}`
  });
};

export { check_file_selected }
