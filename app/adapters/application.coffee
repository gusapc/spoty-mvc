`import DS from 'ember-data'`

ApplicationAdapter = DS.ActiveModelAdapter.extend
	host: 'http://serverlocal.com:4000'

`export default ApplicationAdapter`