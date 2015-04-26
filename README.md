# Spoty

## Instalación
Antes de clonar el repositorio asegúrense de tener git instalado, en la terminal ejecuten `git`, si tienen error instálenlo.

1. cd ~/
2. git clone https://github.com/arnaldo2792/spoty-mvc.git
3. cd spoty-mvc
4. bower install
5. npm install
6. rm README.md

Con los pasos anteriores tendrán disponible en el proyecto bootstrap y la sintaxis de coffeescript, el primer comando es para pasarse a su directorio `home`, para saber en dónde se encuentran y puedan saber donde lo clonaron hagan `pwd`.

No solamente copien y peguen, hagan cambios y no suban este proyecto con Omac si no se va a dar cuenta que lo hice yo, copien los archivos dentro de su propia proyecto esto córranlo en otro aparte.

## Archivos
Estos son los archivos a modificar, pueden dar click en el nombre del archivo para verlo 


#### [app/router.js](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/router.coffee)

Este archivo lo renombramos a `router.coffee` y cambiamos la sintaxis a coffeescript

```coffeescript
`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
	location: config.locationType
	
Router.map ()->
	@route 'canciones', path: '/'

`export default Router`
```

En este archivo se definen las rutas para la aplicación, para mas información acerca de cómo declarar las rutas den click [aquí](http://guides.emberjs.com/v1.10.0/routing/defining-your-routes/)

#### [app/adapters/applicacion.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/adapters/application.coffee)

En este archivo se define qué tipo de adapter se utilizará para la aplicación, si no clonaron el repositorio y solo siguen esto se darán cuenta de que no tienen el directorio adapters, lo tienen que crear y luego al archivo

```coffeescript
`import DS from 'ember-data'`

ApplicationAdapter = DS.ActiveModelAdapter.extend
	host: 'http://elservidordeomac.com:supuerto' # Lo cambian para que funcione con su puerto de rails

`export default ApplicationAdapter`

```

Si quieren saber más sobre los tipos de adapters que existen hagan click [aquí](http://guides.emberjs.com/v1.10.0/models/customizing-adapters/)

#### [app/models/cancion.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/models/cancion.coffee)

Este archivo contiene la difinición del modelo `cancion`

```coffeescript

`import DS from 'ember-data'`

Cancion = DS.Model.extend
	nombre: DS.attr('string')
	artista: DS.attr('string')

`export default Cancion`
```

#### [app/routes/canciones.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/routes/canciones.coffee)

Aquí definimos la ruta para `/canciones`, estableciendo como modelo a todas las canciones que existan en memoria

```coffeescript

`import Ember from 'ember'`

CancionesRoute = Ember.Route.extend
	model: ->
		@store.find('cancion')
		
`export default CancionesRoute`
```
	
Información acerca de los hooks del route [aquí](http://guides.emberjs.com/v1.10.0/routing/specifying-a-routes-model/)

#### [app/controllers/canciones.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/controllers/canciones.coffee)

Este es controlador para la ruta `/canciones`

```coffeescript
`import Ember from 'ember'`

CancionesController = Ember.Controller.extends
	nombreCancion: ''
	nombreArtista: ''

	tituloVacio: Ember.computed.empty('nombreCancion')
	artistaVacio: Ember.computed.empty('nombreArtista')

	cancionValida: (->
		!@get('tituloVacio') && !@get('artistaVacio')
	).property('tituloVacio', 'artistaVacio')

	actions:
		crearCancion: ->
			return if !@get 'cancionValida'
		
			currentId = @get 'currentId'
			cancion = @store.createRecord 'cancion', 
				nombre: @get('nombreCancion')
				artista: @get('nombreArtista')
			
			cancion.save()
		
			@setProperties
				nombreArtista: ''
				nombreCancion: ''

`export default CancionesController`
```
	
Información acerca de computed properties [aquí](http://guides.emberjs.com/v1.10.0/object-model/computed-properties/) y sobre obtener propiedades del controlador en funciones [aquí](http://guides.emberjs.com/v1.10.0/object-model/classes-and-instances/)


####  [app/templates/canciones.hbs](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/templates/canciones.hbs)

Aquí se encuentra la definición de la vista, no puedo incluir el código aquí pero información acerca del `itemController` [aquí](http://guides.emberjs.com/v1.10.0/controllers/representing-multiple-models-with-arraycontroller/#toc_item-controller)

#### [app/controllers/cancion.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/controllers/cancion.coffee)

Aquí está la definición del `CancionController` utilizado en `{{each}}` de la vista

```coffeescript
`import Ember from 'ember'`

CancionController = Ember.Controller.extend
	isEditing: false

	text: (->
		if @get('isEditing') then 'Guardar' else 'Editar'
	).property('isEditing')

	actions:
		eliminarCancion: ->
			@get('model').destroyRecord()
		
		editarCancion: ->
			if @get 'isEditing'
				@get('model').save()
				@set('isEditing', false)
			else
				@set('isEditing', true)
			

`export default CancionController`
```

####  [app/initializers/inflectors-initializer.coffee](https://github.com/arnaldo2792/spoty-mvc/blob/master/app/initializers/inflectors-initializer.coffee)

Aquí definimos que vamos a renombrar `cancion` por su plural `canciones`

```coffeescript
`import Ember from 'ember'`
InflectorInitializer = 
	name: 'inflections'
	initialize: ->
		inflector = Ember.Inflector.inflector
		inflector.irregular 'cancion', 'canciones'
`export default InflectorInitializer`
```