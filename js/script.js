const ajaxPath = 'php/ajax.php'
init()

async function init() {
  const res = await fetch(ajaxPath, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      operation: 'getNews'
    })
  })
  const initialNews = await res.json()
  initialNews.map(toPost)

  document
    .querySelector('#update')
    .addEventListener('click', updateNews)
  document
    .querySelector('#clean')
    .addEventListener('click', cleanNews)
}

function toPost({ title, description }, timeout) {
  const postImage = $('<div></div>')
    .addClass('image')

  const postTitle = $('<div></div>')
    .addClass('title')
    .text(title)

  const postDescription = $('<div></div>')
    .addClass('description')
    .text(description)

  const post = $('<div></div>')
    .addClass('post')
    .append(postImage)
    .append(postTitle)
    .append(postDescription)

  setTimeout(() => {
    $('.news')
      .append(post.fadeIn())
  }, timeout * 5000)

}

async function updateNews() {
  await fetch(ajaxPath, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      operation: 'updateNews'
    })
  })
  refreshPage()
  init()
}
async function cleanNews() {
  await fetch(ajaxPath, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      operation: 'cleanNews'
    })
  })
  refreshPage()
  init()
}

function refreshPage() {
  $('.news').html('')
}