const canPromise = require('./can-promise')
const QRCode = require('./core/qrcode')
const PngRenderer = require('./renderer/png')
const Utf8Renderer = require('./renderer/utf8')
const SvgRenderer = require('./renderer/svg')

function checkParams(text, opts, cb) {
  if (typeof text === 'undefined') {
    throw new Error('String required as first argument')
  }

  if (typeof cb === 'undefined') {
    cb = opts
    opts = {}
  }

  if (typeof cb !== 'function') {
    if (!canPromise()) {
      throw new Error('Callback required as last argument')
    } else {
      opts = cb || {}
      cb = null
    }
  }

  return {
    opts: opts,
    cb: cb
  }
}

function getTypeFromFilename(path) {
  return path.slice((path.lastIndexOf('.') - 1 >>> 0) + 2).toLowerCase()
}

function getRendererFromType(type) {
  switch (type) {
    case 'svg':
      return SvgRenderer

    case 'txt':
    case 'utf8':
      return Utf8Renderer

    case 'png':
    case 'image/png':
    default:
      return PngRenderer
  }
}

function render(renderFunc, text, params) {
  if (!params.cb) {
    return new Promise(function (resolve, reject) {
      try {
        const data = QRCode.create(text, params.opts)
        return renderFunc(data, params.opts, function (err, data) {
          return err ? reject(err) : resolve(data)
        })
      } catch (e) {
        reject(e)
      }
    })
  }

  try {
    const data = QRCode.create(text, params.opts)
    return renderFunc(data, params.opts, params.cb)
  } catch (e) {
    params.cb(e)
  }
}

exports.create = QRCode.create

exports.toFile = function toFile(path, text, opts, cb) {
  // split this text into 6 parts
  // let len = text.length
  // let text1 = text.substring(0, len/6)
  // let text2 = text.substring(len/6, 2*len/6)
  // let text3 = text.substring(2*len/6, 3*len/6)
  // let text4 = text.substring(3*len/6, 4*len/6)
  // let text5 = text.substring(4*len/6, 5*len/6)
  // let text6 = text.substring(5*len/6, len)

  // let parts = [];
  // for (let i = 0; i < 6; i++) {
  //   let start = i * len / 6;
  //   let end = (i + 1) * len / 6;
  //   parts.push(text.substring(start, end));
  // }

  // console.log(parts);
  // console.log(path);

  // let filename = path.slice(0, path.lastIndexOf('.'))
  // let ext = path.slice(path.lastIndexOf('.'))

  // let paths = []
  // for (let i = 0; i < 6; i++) {
  //   paths.push(filename + i + ext)
  // }

  // console.log(paths)

  if (typeof path !== 'string' || !(typeof text === 'string' || typeof text === 'object')) {
    throw new Error('Invalid argument')
  }

  if ((arguments.length < 3) && !canPromise()) {
    throw new Error('Too few arguments provided')
  }

  // for (let i = 0; i < 6; i++) {
  //   const params = checkParams(parts[i], opts, cb)
  //   const type = params.opts.type || getTypeFromFilename(paths[i])
  //   const renderer = getRendererFromType(type)

  //   const renderToFile = renderer.renderToFile.bind(null, paths[i])

  //   render(renderToFile, parts[i], params)
  // }
  const params = checkParams(text, opts, cb)
  const type = params.opts.type || getTypeFromFilename(path)
  const renderer = getRendererFromType(type)

  //console.log(renderer)
  const renderToFile = renderer.renderToFile.bind(null, path)

  return render(renderToFile, text, params)
}
