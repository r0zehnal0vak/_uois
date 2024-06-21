
HOME_NET = 'any'
EXTERNAL_NET = 'any'
include 'snort_defaults.lua'
stream = { }
stream_ip = { }
stream_icmp = { }
stream_tcp = { }
stream_udp = { }
stream_user = { }
stream_file = { }
arp_spoof = { }
back_orifice = { }
dns = { }
imap = { }
netflow = {}
normalizer = { }
pop = { }
rpc_decode = { }
sip = { }
ssh = { }
ssl = { }
telnet = { }
cip = { }
dnp3 = { }
iec104 = { }
mms = { }
modbus = { }
s7commplus = { }
dce_smb = { }
dce_tcp = { }
dce_udp = { }
dce_http_proxy = { }
dce_http_server = { }
gtp_inspect = default_gtp
port_scan = default_med_port_scan
smtp = default_smtp
ftp_server = default_ftp_server
ftp_client = { }
ftp_data = { }
http_inspect = default_http_inspect
http2_inspect = { }
file_id = { rules_file = 'file_magic.rules' }
file_policy = { }
appid =
{
  
}
wizard = default_wizard
binder =
{
    
    { when = { proto = 'udp', ports = '53', role='server' },  use = { type = 'dns' } },
    { when = { proto = 'tcp', ports = '53', role='server' },  use = { type = 'dns' } },
    { when = { proto = 'tcp', ports = '102', role = 'server' }, use = { type = 's7commplus' } },
    { when = { proto = 'tcp', ports = '111', role='server' }, use = { type = 'rpc_decode' } },
    { when = { proto = 'tcp', ports = '502', role='server' }, use = { type = 'modbus' } },
    { when = { proto = 'tcp', ports = '2123 2152 3386', role='server' }, use = { type = 'gtp_inspect' } },
    { when = { proto = 'tcp', ports = '2404', role='server' }, use = { type = 'iec104' } },
    { when = { proto = 'udp', ports = '22222', role = 'server' }, use = { type = 'cip' } },
    { when = { proto = 'tcp', ports = '44818', role = 'server' }, use = { type = 'cip' } },
    { when = { proto = 'tcp', service = 'dcerpc' },  use = { type = 'dce_tcp' } },
    { when = { proto = 'udp', service = 'dcerpc' },  use = { type = 'dce_udp' } },
    { when = { proto = 'udp', service = 'netflow' }, use = { type = 'netflow' } },
    { when = { service = 'netbios-ssn' },      use = { type = 'dce_smb' } },
    { when = { service = 'dce_http_server' },  use = { type = 'dce_http_server' } },
    { when = { service = 'dce_http_proxy' },   use = { type = 'dce_http_proxy' } },
    { when = { service = 'cip' },              use = { type = 'cip' } },
    { when = { service = 'dnp3' },             use = { type = 'dnp3' } },
    { when = { service = 'dns' },              use = { type = 'dns' } },
    { when = { service = 'ftp' },              use = { type = 'ftp_server' } },
    { when = { service = 'ftp-data' },         use = { type = 'ftp_data' } },
    { when = { service = 'gtp' },              use = { type = 'gtp_inspect' } },
    { when = { service = 'imap' },             use = { type = 'imap' } },
    { when = { service = 'http' },             use = { type = 'http_inspect' } },
    { when = { service = 'http2' },            use = { type = 'http2_inspect' } },
    { when = { service = 'iec104' },           use = { type = 'iec104' } },
    { when = { service = 'mms' },              use = { type = 'mms' } },
    { when = { service = 'modbus' },           use = { type = 'modbus' } },
    { when = { service = 'pop3' },             use = { type = 'pop' } },
    { when = { service = 'ssh' },              use = { type = 'ssh' } },
    { when = { service = 'sip' },              use = { type = 'sip' } },
    { when = { service = 'smtp' },             use = { type = 'smtp' } },
    { when = { service = 'ssl' },              use = { type = 'ssl' } },
    { when = { service = 'sunrpc' },           use = { type = 'rpc_decode' } },
    { when = { service = 's7commplus' },       use = { type = 's7commplus' } },
    { when = { service = 'telnet' },           use = { type = 'telnet' } },
    { use = { type = 'wizard' } }
}
references = default_references
classifications = default_classifications
ips =
{
    variables = {
        nets = {
        EXTERNAL_NET = 'any',
        HOME_NET = 'any',
        SMTP_SERVERS = 'any',
        SQL_SERVERS = 'any',
        SIP_SERVERS = 'any',
        HTTP_SERVERS = 'any',
        TELNET_SERVERS = 'any'
        },
        ports = {
        HTTP_PORTS = HTTP_PORTS,
        FILE_DATA_PORTS = FILE_DATA_PORTS,
        SIP_PORTS = SIP_PORTS,
        SSH_PORTS = SSH_PORTS,
        ORACLE_PORTS = ORACLE_PORTS,
        FTP_PORTS = FTP_PORTS
        }
   }
}

alert_json =
{
   file = true,
   limit = 100,
   fields = 'timestamp class msg priority src_addr src_port dst_addr dst_port',
}

if ( tweaks ~= nil ) then
    include(tweaks .. '.lua')
end
