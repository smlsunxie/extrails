databaseChangeLog = {

	changeSet(author: "Spooky (generated)", id: "1386750958225-1") {
		addNotNullConstraint(columnDataType: "bigint", columnName: "user_id", tableName: "event")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-2") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "creator", tableName: "event_detail")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-3") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "description", tableName: "event_detail")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-4") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "main_image", tableName: "event_detail")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-5") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "address", tableName: "store")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-6") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "telphone", tableName: "store")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-7") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "address", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-8") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "description", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-9") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "email", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-10") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "mobile", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-11") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "telphone", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-12") {
		dropNotNullConstraint(columnDataType: "varchar(255)", columnName: "title", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-13") {
		createIndex(indexName: "name_uniq_1386750957995", tableName: "brand", unique: "true") {
			column(name: "name")
		}
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-14") {
		createIndex(indexName: "name_uniq_1386750958016", tableName: "event_detail", unique: "true") {
			column(name: "name")
		}
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-15") {
		createIndex(indexName: "unique_title", tableName: "store_cost_detail", unique: "true") {
			column(name: "date")

			column(name: "title")
		}
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-16") {
		dropColumn(columnName: "birthday", tableName: "user")
	}

	changeSet(author: "Spooky (generated)", id: "1386750958225-17") {
		dropTable(tableName: "registration_code")
	}
}
