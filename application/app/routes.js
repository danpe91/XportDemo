module.exports = function(app, sequelize, datatypes) {

	var Todo = require('./models/todo')(sequelize, datatypes);

	// api ---------------------------------------------------------------------
	// get all todos
	app.get('/api/todos', function(req, res) {

		// use mongoose to get all todos in the database
		Todo.findAll().then(function(todos) {

			res.json(todos); // return all todos in JSON format
		}).catch(function(err) {
			// if there is an error retrieving, send the error. nothing after res.send(err) will execute
			res.send(err);
		});
	});

	// create todo and send back all todos after creation
	app.post('/api/todos', function(req, res) {

		// create a todo, information comes from AJAX request from Angular
		Todo.upsert({
			text : req.body.text,
			done : false
		}).then(function() {
			// get and return all the todos after you create another
			console.log('Inserted');
			return Todo.findAll();
		}).then(function(todos) {
			console.log('reading');
			console.log(todos);
			return res.json(todos);
		}).catch(function(err, todo) {
			console.error(err);
			res.send(err);
		});
	});

	// delete a todo
	app.delete('/api/todos/:todo_id', function(req, res) {
		console.log(req.params);
		Todo.destroy({
			where: {
				id : req.params.todo_id
			}
		}).then(function() {
			// get and return all the todos after you create another
			return Todo.findAll();
		}).then(function(todos) {
			return res.json(todos);
		}).catch(function(err) {
			return res.send(err);
		});
	});

	// application -------------------------------------------------------------
	app.get('*', function(req, res) {
		res.sendfile('./public/index.html'); // load the single view file (angular will handle the page changes on the front-end)
	});
};
