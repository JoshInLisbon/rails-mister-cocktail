const click_to_expand = () => {
  document.addEventListener('click', (event) => {
    console.log(event.target.id)
  });
};

export { click_to_expand }
