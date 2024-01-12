import dnssd from 'dnssd'
import express from 'express'
import morgan from 'morgan'
import path from 'node:path'

interface AppParams {
  port: number
}

export default function createGeogebraApp(args: AppParams) {
  const root = '/apps/geogebra'

  const ad = new dnssd.Advertisement('_http._tcp,_abittiapp', args.port, {
    name: 'GeoGebra',
    txt: {
      path: root,
      ext: '.ggb',
      mime: 'application/vnd.geogebra.file',
      cas: '1'
    }
  })

  const app = express()
  app.use(morgan('combined'))
  app.use(root, express.static(path.resolve(__dirname, '../public')))

  const server = app.listen(args.port)
  ad.start()
  server.on('close', () => ad.stop())
  return server
}
