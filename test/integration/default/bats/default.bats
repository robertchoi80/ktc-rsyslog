# vim: ft=sh:
@test "should have rsyslogd running" {
  [ "$(ps aux | grep rsyslogd | grep -v grep)" ]
}
