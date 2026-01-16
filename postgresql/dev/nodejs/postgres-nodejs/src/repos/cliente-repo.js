const pool = require('../pool');
const toCamelCase = require('./utils/to-camel-case');
const { query } = require('../pool');

class ClienteRepo {

  static async setSchema() {
      //default schema seemed to get lost sometimes;
      await pool.query('SET search_path = comercio;'); 
  }
  static async find() {
    await this.setSchema();
    const { rows } = await pool.query('SELECT * FROM clientes;');

    return toCamelCase(rows);
  }

  static async findById(id) {
    await this.setSchema();
    const { rows } = await pool.query('SELECT * FROM clientes WHERE id_cliente = $1;', [
      id,
    ]);

    return toCamelCase(rows)[0];
  }

  static async insert(nombres, apellidos, nif, fechaAlta, activo, comentarios) {
    await this.setSchema();
    const {
      rows,
    } = await pool.query(
      'INSERT INTO clientes (nif, nombres, apellidos, fecha_alta, activo, comentarios) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;',
      [nombres, apellidos, nif, fechaAlta, activo, comentarios]
    );

    return toCamelCase(rows)[0];
  }

  static async update(id, nombres, apellidos) {
    await this.setSchema();
    const {
      rows,
    } = await pool.query(
      'UPDATE clientes SET nombres = $1, apellidos = $2 WHERE id_cliente = $3 RETURNING *;',
      [nombres, apellidos, id]
    );

    return toCamelCase(rows)[0];
  }

  static async delete(id) {
    await this.setSchema();
    const {
      rows,
    } = await pool.query('DELETE FROM clientes WHERE id_cliente = $1 RETURNING *;', [id]);

    return toCamelCase(rows)[0];
  }

  static async count() {
    await this.setSchema();
    const { rows } = await pool.query('SELECT COUNT(*) FROM clientes;');

    return parseInt(rows[0].count);
  }
}

module.exports = ClienteRepo;
