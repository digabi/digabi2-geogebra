import dnssd from 'dnssd'
import express from 'express'
import morgan from 'morgan'
import path from 'node:path'

interface AppParams {
  port: number
}

export default function createGeogebraApp(args: AppParams) {
  const root = '/'

  const ad = new dnssd.Advertisement('_http._tcp', args.port, {
    name: 'GeoGebra',
    txt: { path: '/.well-known/appspecific/dev.abitti.json' }
  })

  const app = express()
  app.use(morgan('combined'))

  app.use('/.well-known/appspecific/dev.abitti.json', (req, res) =>
    res.json({
      geogebra: {
        name: 'GeoGebra',
        path: `${root}/`,
        filetypes: [{ mime: 'application/vnd.geogebra.file', glob: '*.ggb' }, { glob: '*.ggb' }],
        categories: ['cas']
      }
    })
  )

  app.use(root, express.static(path.resolve(__dirname, '../public')))

  const server = app.listen(args.port)
  ad.start()
  server.on('close', () => ad.stop())
  return server
}
