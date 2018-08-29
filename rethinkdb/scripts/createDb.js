
var r = require('rethinkdb');
var config = require(__dirname + "/config.js");

r.connect(config.rethinkdb, function (err, conn) {
  if (err) {
    console.log("Could not open a connection to initialize the database");
    console.log(err.message);
    process.exit(1);
  }

  r.dbCreate(config.rethinkdb.db).run(conn)
    .finally(function () {
      return r.db('rethinkdb').table('users').insert({id: config.user, password: config.password}).run(conn);
    }).finally(function () {
      return r.db('rethinkdb').table('users').get('admin').update({password: {password: config.rethinkdb.newPassword, iterations: 1024}});
    }).finally(function (){
      return r.db(config.rethinkdb.db).grant(config.user, {read: true, write: true, config: true}).run(conn);
    }).then(function(result) {
      console.log(`Database '${config.rethinkdb.db}' created successfully!`);
      conn.close();
    }).error(function (err) {
      if (err) {
        console.log(err.msg);
        process.exit(1);
      }
    });
});
