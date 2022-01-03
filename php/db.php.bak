<?php
class DB {
	private $pdo;

	protected static $instance;

	public static function getInstance() {
		return static::$instance ?: static::$instance = new static;
	}

	public function __construct() {}
	public function __wakeup() {}
	public function __clone() {}

	private static function checkMethod($class, $name, $args) {
		if(method_exists($class, $name)) {
			return call_user_func_array([$class, $name], $args);
		} else {
			throw new Exception('Call to undefined method '.get_class($class).'::'.$name.'()');
		}
	}

	public static function __callStatic($name, $args) {
		return self::checkMethod(static::getInstance(), $name, $args);
	}


	private function connect($data = []) {
		try {
			$this->pdo = new PDO(
				'mysql:host='.$data['host'].'; dbname='.$data['name'], $data['user'], $data['pass']
			);
			$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$this->exec('SET names "utf8"');
		} catch (PDOException $e) {
			$this->error($e, 'Connection');
		}
	}

	private function error($e, $query = '', $params = []) {
		throw new DBException('DB: '.self::str($query, $params), $e->errorInfo[1], $e->errorInfo[2]);
	}

	private function query($sql) {
		try {
			return $this->pdo->query($sql);
		} catch (PDOException $e) {
			$this->error($e, $sql);
		}
	}

	private function str($sql, $params = []) {
		foreach($params as $param) {
			$sql = preg_replace('~\?~', self::quote($param), $sql, 1);
		}
		return $sql;

	}

	private function exec($sql, $param = []) {
		try {
			$sth = $this->pdo->prepare($sql);
			$sth->execute($param);
			return $sth;
		} catch (PDOException $e) {
			$this->error($e, $sql, $param);
		}
	}

	private function quote($value, $parameter_type = null) {
		if(is_null($value)) return 'NULL';
		switch($parameter_type) {
			case 'str':  $parameter_type = PDO::PARAM_STR;  break;
			case 'int':  $parameter_type = PDO::PARAM_INT;  break;
			case 'null': $parameter_type = PDO::PARAM_NULL; break;
			case 'bool': $parameter_type = PDO::PARAM_BOOL; break;
		}
		return $this->pdo->quote($value, $parameter_type);
	}

	private function num($sql) {
		return $sql->rowCount();
	}

	private function arr($sql, $param = []) {
		$q = $param ? $this->exec($sql, $param) : $this->query($sql);
		$fetch = $q->fetchAll(PDO::FETCH_ASSOC);
		return $fetch;
	}

	private function line($sql, $param = []) {
		$q = $param ? $this->exec($sql, $param) : $this->query($sql);
		$fetch = $q->fetch(PDO::FETCH_ASSOC);
		return $fetch;
	}

	private function one($sql, $param = []) {
		$q = $param ? $this->exec($sql, $param) : $this->query($sql);
		$fetch = $q->fetchColumn();
		return $fetch;
	}

	private function last_id() {
		try {
			return $this->pdo->lastInsertId();
		} catch (PDOException $e) {
			$this->error($e, 'Last ID');
		}
	}

	private function columns($tbl) {
		return Func::arrColumn(self::arr(
			'SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=?', [$tbl]
		), 'COLUMN_NAME');
	}

	private function insertRow($tbl) {
		self::exec('INSERT INTO '.$tbl.' () VALUES ()');
		return self::last_id();
	}

	private function insertArr($tbl, $arr = [], $update = null, $return = false) {
		$query = '
			INSERT INTO '.$tbl.' ('.implode(', ', array_keys($arr)).')
			VALUES ('.implode(', ', array_fill(0, count($arr), '?')).')';
		$value = array_values($arr);
		if($update) {
			$query .= ' ON DUPLICATE KEY UPDATE `'.implode('`=?, `', array_keys($update)).'`=?';
			$value = array_merge($value, array_values($update));
		}
		if($return) {
			return self::str($query, $value);
		} else {
			self::exec($query, $value);
			return self::last_id();
		}
	}

	private function updateArr($tbl, $arr, $where, $return = false) {
		$query = 'UPDATE '.$tbl.' SET '.implode('=?, ', array_keys($arr)).'=? WHERE '.$where;
		$value = array_values($arr);
		if($return) {
			return self::str($query, $value);
		} else {
			self::exec($query, $value);
			return self::last_id();
		}
	}
}

class DBException extends Exception {
	public function __construct($query, $code, $errString) {
		$this->message = $query.PHP_EOL.$errString;
		$this->code = $code;
	}
}
