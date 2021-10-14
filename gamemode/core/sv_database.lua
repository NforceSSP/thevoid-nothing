function ntCreateSQLTable()
	if sql.TableExists("nothing_player") then return end
	local query

	query = mysql:Create("nothing_player")
			query:Create("steamid", "VARCHAR(20) NOT NULL")
			query:Create("play_time", "INT(11) UNSIGNED DEFAULT NULL")
			query:Create("last_join_time", "INT(11) UNSIGNED DEFAULT NULL")
			query:PrimaryKey("steamid")
	query:Execute()
end