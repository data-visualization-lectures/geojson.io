const OPENFREEMAP_STYLE_BASE = 'https://tiles.openfreemap.org/styles';

module.exports = [
  {
    title: 'Streets',
    style: `${OPENFREEMAP_STYLE_BASE}/bright`,
    featureColorMode: 'default',
    enableFog: false
  },
  {
    title: 'Satellite Streets',
    style: `${OPENFREEMAP_STYLE_BASE}/3d`,
    featureColorMode: 'satellite',
    enableFog: false
  },
  {
    title: 'Outdoors',
    style: `${OPENFREEMAP_STYLE_BASE}/liberty`,
    featureColorMode: 'default',
    enableFog: false
  },
  {
    title: 'Light',
    style: `${OPENFREEMAP_STYLE_BASE}/positron`,
    featureColorMode: 'default',
    enableFog: true
  },
  {
    title: 'Dark',
    style: `${OPENFREEMAP_STYLE_BASE}/dark`,
    featureColorMode: 'dark',
    enableFog: true
  },
  {
    title: 'OSM',
    style: {
      name: 'osm',
      version: 8,
      sources: {
        'osm-raster-tiles': {
          type: 'raster',
          tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
          tileSize: 256,
          attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
      },
      layers: [
        {
          id: 'osm-raster-layer',
          type: 'raster',
          source: 'osm-raster-tiles',
          minzoom: 0,
          maxzoom: 22
        }
      ]
    },
    featureColorMode: 'default',
    enableFog: true
  }
];
