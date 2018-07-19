module.exports = (sequelize, Datatypes) => {
	let todoModel = sequelize.define('todo', {
		text: {
			type: Datatypes.STRING
		},
		done: {
			type: Datatypes.STRING
		}
	});

	todoModel.sync();

	return todoModel;
}
