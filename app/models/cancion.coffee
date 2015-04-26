`import DS from 'ember-data'`

Cancion = DS.Model.extend
	nombre: DS.attr('string')
	artista: DS.attr('string')

`export default Cancion`