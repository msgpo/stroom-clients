#!/usr/bin/env bash

# Created by argbash-init v2.6.1
# ARG_OPTIONAL_SINGLE([headers],[h],[File containing additional HTTP headers. In the form 'HeaderName:header value'],[])
# ARG_OPTIONAL_BOOLEAN([secure],[s],[Check for valid certificates if running over HTTPS],[off])
# ARG_OPTIONAL_BOOLEAN([delete-after-sending],[d],[Delete log files after sending them],[off])
# ARG_OPTIONAL_BOOLEAN([pretty],[p],[Use colours in the output, it is recomended to disable this when sending the results to a log file],[on])
# ARG_OPTIONAL_SINGLE([file-regex],[r],[The regex pattern used to match files that will be sent. E.g. '.*/[a-z]+-[0-9]{4}-[0-9]{2}-[0-9]{2}T.*\.log'. Regex syntax is that used in bash. If not set, all files in the directory will be sent.],[".*/.*\.log"])
# ARG_OPTIONAL_SINGLE([max-sleep],[m],[Max time allowed to sleep (e.g. to avoid all cron's in the estate sending log files at the same time)],[0])
# ARG_OPTIONAL_SINGLE([key],[],[The client's private key file path. The private key should be in PEM format],[])
# ARG_OPTIONAL_SINGLE([key-type],[],[The type of the client's private key],[PEM])
# ARG_OPTIONAL_SINGLE([cert],[],[The client's certificate file path. The certificate should be in PEM format],[])
# ARG_OPTIONAL_SINGLE([cert-type],[],[The type of the client's certificate],[PEM])
# ARG_OPTIONAL_SINGLE([cacert],[],[The certificate authority's certificate file path. The certificate must be in PEM format],[])
# ARG_POSITIONAL_SINGLE([log-dir],[Directory to look for log files],[])
# ARG_POSITIONAL_SINGLE([feed],[ Your feed name given to you],[])
# ARG_POSITIONAL_SINGLE([system],[Your system name, i.e. what your project/service or capability is known as],[])
# ARG_POSITIONAL_SINGLE([environment],[Your environment name. Usually SITE_DEPLOYMENT],[])
# ARG_POSITIONAL_SINGLE([stroom-url],[The URL you are sending data to (N.B. This should be the HTTPS URL)],[])
# ARG_DEFAULTS_POS()
# ARG_HELP([This script will send log files to Stroom.])
# ARG_VERSION([echo $0 v0.1])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.7.1 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
  local _ret=$2
  test -n "$_ret" || _ret=1
  test "$_PRINT_HELP" = yes && print_help >&2
  echo "$1" >&2
  exit ${_ret}
}


begins_with_short_option()
{
  local first_option all_short_options='hsdprmhv'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_log_dir=
_arg_feed=
_arg_system=
_arg_environment=
_arg_stroom_url=
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_headers=
_arg_secure="off"
_arg_delete_after_sending="off"
_arg_pretty="on"
_arg_file_regex=".*/.*\.log"
_arg_max_sleep="0"
_arg_key=
_arg_key_type="PEM"
_arg_cert=
_arg_cert_type="PEM"
_arg_cacert=


print_help()
{
  printf '%s\n' "This script will send log files to Stroom."
  printf 'Usage: %s [-h|--headers <arg>] [-s|--(no-)secure] [-d|--(no-)delete-after-sending] [-p|--(no-)pretty] [-r|--file-regex <arg>] [-m|--max-sleep <arg>] [--key <arg>] [--key-type <arg>] [--cert <arg>] [--cert-type <arg>] [--cacert <arg>] [-h|--help] [-v|--version] <log-dir> <feed> <system> <environment> <stroom-url>\n' "$0"
  printf '\t%s\n' "<log-dir>: Directory to look for log files"
  printf '\t%s\n' "<feed>:  Your feed name given to you"
  printf '\t%s\n' "<system>: Your system name, i.e. what your project/service or capability is known as"
  printf '\t%s\n' "<environment>: Your environment name. Usually SITE_DEPLOYMENT"
  printf '\t%s\n' "<stroom-url>: The URL you are sending data to (N.B. This should be the HTTPS URL)"
  printf '\t%s\n' "-h, --headers: File containing additional HTTP headers. In the form 'HeaderName:header value' (no default)"
  printf '\t%s\n' "-s, --secure, --no-secure: Check for valid certificates if running over HTTPS (off by default)"
  printf '\t%s\n' "-d, --delete-after-sending, --no-delete-after-sending: Delete log files after sending them (off by default)"
  printf '\t%s\n' "-p, --pretty, --no-pretty: Use colours in the output, it is recomended to disable this when sending the results to a log file (on by default)"
  printf '\t%s\n' "-r, --file-regex: The regex pattern used to match files that will be sent. E.g. '.*/[a-z]+-[0-9]{4}-[0-9]{2}-[0-9]{2}T.*\.log'. Regex syntax is that used in bash. If not set, all files in the directory will be sent. (default: '".*/.*\.log"')"
  printf '\t%s\n' "-m, --max-sleep: Max time allowed to sleep (e.g. to avoid all cron's in the estate sending log files at the same time) (default: '0')"
  printf '\t%s\n' "--key: The client's private key file path. The private key should be in PEM format (no default)"
  printf '\t%s\n' "--key-type: The type of the client's private key (default: 'PEM')"
  printf '\t%s\n' "--cert: The client's certificate file path. The certificate should be in PEM format (no default)"
  printf '\t%s\n' "--cert-type: The type of the client's certificate (default: 'PEM')"
  printf '\t%s\n' "--cacert: The certificate authority's certificate file path. The certificate must be in PEM format (no default)"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\t%s\n' "-v, --version: Prints version"
}


parse_commandline()
{
  _positionals_count=0
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -h|--headers)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_headers="$2"
        shift
        ;;
      --headers=*)
        _arg_headers="${_key##--headers=}"
        ;;
      -h*)
        _arg_headers="${_key##-h}"
        ;;
      -s|--no-secure|--secure)
        _arg_secure="on"
        test "${1:0:5}" = "--no-" && _arg_secure="off"
        ;;
      -s*)
        _arg_secure="on"
        _next="${_key##-s}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          begins_with_short_option "$_next" && shift && set -- "-s" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        ;;
      -d|--no-delete-after-sending|--delete-after-sending)
        _arg_delete_after_sending="on"
        test "${1:0:5}" = "--no-" && _arg_delete_after_sending="off"
        ;;
      -d*)
        _arg_delete_after_sending="on"
        _next="${_key##-d}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          begins_with_short_option "$_next" && shift && set -- "-d" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        ;;
      -p|--no-pretty|--pretty)
        _arg_pretty="on"
        test "${1:0:5}" = "--no-" && _arg_pretty="off"
        ;;
      -p*)
        _arg_pretty="on"
        _next="${_key##-p}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          begins_with_short_option "$_next" && shift && set -- "-p" "-${_next}" "$@" || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        ;;
      -r|--file-regex)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_file_regex="$2"
        shift
        ;;
      --file-regex=*)
        _arg_file_regex="${_key##--file-regex=}"
        ;;
      -r*)
        _arg_file_regex="${_key##-r}"
        ;;
      -m|--max-sleep)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_max_sleep="$2"
        shift
        ;;
      --max-sleep=*)
        _arg_max_sleep="${_key##--max-sleep=}"
        ;;
      -m*)
        _arg_max_sleep="${_key##-m}"
        ;;
      --key)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_key="$2"
        shift
        ;;
      --key=*)
        _arg_key="${_key##--key=}"
        ;;
      --key-type)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_key_type="$2"
        shift
        ;;
      --key-type=*)
        _arg_key_type="${_key##--key-type=}"
        ;;
      --cert)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_cert="$2"
        shift
        ;;
      --cert=*)
        _arg_cert="${_key##--cert=}"
        ;;
      --cert-type)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_cert_type="$2"
        shift
        ;;
      --cert-type=*)
        _arg_cert_type="${_key##--cert-type=}"
        ;;
      --cacert)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_cacert="$2"
        shift
        ;;
      --cacert=*)
        _arg_cacert="${_key##--cacert=}"
        ;;
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      -v|--version)
        echo $0 v0.1
        exit 0
        ;;
      -v*)
        echo $0 v0.1
        exit 0
        ;;
      *)
        _last_positional="$1"
        _positionals+=("$_last_positional")
        _positionals_count=$((_positionals_count + 1))
        ;;
    esac
    shift
  done
}


handle_passed_args_count()
{
  local _required_args_string="'log-dir', 'feed', 'system', 'environment' and 'stroom-url'"
  test "${_positionals_count}" -ge 5 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 5 (namely: $_required_args_string), but got only ${_positionals_count}." 1
  test "${_positionals_count}" -le 5 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 5 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
  local _positional_name _shift_for=$1
  _positional_names="_arg_log_dir _arg_feed _arg_system _arg_environment _arg_stroom_url "

  shift "$_shift_for"
  for _positional_name in ${_positional_names}
  do
    test $# -gt 0 || break
    eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
    shift
  done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash
# ] <-- needed because of Argbash
