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