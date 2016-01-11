#!/bin/bash
# $1 - path to directory with mysql database files 

#######################################
#   TEST CASE:                        #
#      relative=7d&step=24h           #
#######################################

read -r -d '' OUT <<EOF
use box_utf8;

select @topic_temperature := id from t_bios_measurement_topic where device_id=(select id_discovered_device from t_bios_discovered_device where name='AVG-SRV') and units='C' and topic='temperature.thermal_zone0@AVG-SRV';

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '1 day ago' +%F` 04:00:00"), 10, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '1 day ago' +%F` 15:00:00"), 20, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '1 day ago' +%F` 16:00:00"), 30, 0, @topic_temperature);
/* timestamp: `date -ud '0 day ago 00:00:00' +%s`    avg_24h: 20 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '2 day ago' +%F` 01:00:00"), 100, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '2 day ago' +%F` 17:00:00"), 200, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '2 day ago' +%F` 23:00:00"), 300, 0, @topic_temperature);
/* timestamp: `date -ud '1 day ago 00:00:00' +%s`    avg_24h: 200 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '3 day ago' +%F` 04:00:00"), 20, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '3 day ago' +%F` 16:00:00"), 40, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '3 day ago' +%F` 17:00:00"), 60, 0, @topic_temperature);
/* timestamp: `date -ud '2 day ago 00:00:00' +%s`    avg_24h: 40 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '4 day ago' +%F` 02:00:00"), 200, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '4 day ago' +%F` 14:00:00"), 400, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '4 day ago' +%F` 16:00:00"), 600, 0, @topic_temperature);
/* timestamp: `date -ud '3 day ago 00:00:00' +%s`    avg_24h: 400 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '5 day ago' +%F` 03:00:00"), 40, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '5 day ago' +%F` 13:00:00"), 60, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '5 day ago' +%F` 15:00:00"), 80, 0, @topic_temperature);
/* timestamp: `date -ud '4 day ago 00:00:00' +%s`    avg_24h: 60 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '6 day ago' +%F` 01:00:00"), 400, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '6 day ago' +%F` 15:00:00"), 600, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '6 day ago' +%F` 16:00:00"), 800, 0, @topic_temperature);
/* timestamp: `date -ud '5 day ago 00:00:00' +%s`    avg_24h: 600 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '7 day ago' +%F` 01:00:00"), 60, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '7 day ago' +%F` 15:00:00"), 80, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '7 day ago' +%F` 17:00:00"), 100, 0, @topic_temperature);
/* timestamp: `date -ud '6 day ago 00:00:00' +%s`    avg_24h: 80 */
/* 7d window midnight aligned: 200 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '8 day ago' +%F` 06:00:00"), 600, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '8 day ago' +%F` 14:00:00"), 1000, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '8 day ago' +%F` 17:00:00"), 560, 0, @topic_temperature);
/* timestamp: `date -ud '7 day ago 00:00:00' +%s`    avg_24h: 720 */
/* 7d window midnight aligned: 300 */

INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '9 day ago' +%F` 06:00:00"), 600, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '9 day ago' +%F` 14:00:00"), 2000, 0, @topic_temperature);
INSERT INTO t_bios_measurement (timestamp, value, scale, topic_id) VALUES (UNIX_TIMESTAMP("`date -ud '9 day ago' +%F` 17:00:00"), 100, 0, @topic_temperature);
/* timestamp: `date -ud '8 day ago 00:00:00' +%s`    acg_24: 900 */
/* 7d window midnight aligned: 400 */
EOF
echo "$OUT" > "$1"/test_averages_relative.sql


AVERAGES_RELATIVE_PATTERNS_1="{\"value\":20,\"timestamp\":`date -ud '0 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":200,\"timestamp\":`date -ud '1 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":40,\"timestamp\":`date -ud '2 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":400,\"timestamp\":`date -ud '3 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":60,\"timestamp\":`date -ud '4 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":600,\"timestamp\":`date -ud '5 day ago 00:00:00' +%s`}"
AVERAGES_RELATIVE_PATTERNS_1="$AVERAGES_RELATIVE_PATTERNS_1 {\"value\":80,\"timestamp\":`date -ud '6 day ago 00:00:00' +%s`}"
echo "$AVERAGES_RELATIVE_PATTERNS_1"

