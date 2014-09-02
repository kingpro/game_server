-module(record_mapper).

-exprecs_prefix(["", operation, ""]).
-compile({parse_transform, exprecs}).

-include("db_schema.hrl").

-include("config_data_names.hrl").
-include("db_table_names.hrl").
-include("../app/include/custom_record.hrl").

-export_records(?DB_TABLE_NAMES).
-export_records(?CONFIG_DATA_NAMES).
-export_records(?CUSTOM_RECORD_NAMES).

-export([get_mapping/1, 
         get_field/2, 
         set_field/3, 
         set_fields/2, 
         has_field/2,
         incr_field/3]).

get_mapping(Name) ->
    record_mapper:info(Name, fields).

get_field(Rec, Field) ->
    record_mapper:get(Field, Rec).

set_field(Rec, Field, Value) ->
    record_mapper:set([{Field, Value}], Rec).

set_fields(Rec, KVS) ->
    record_mapper:set(KVS, Rec).

has_field(Name, Field) ->
    lists:member(Field, info(Name, fields)).

incr_field(Rec, Field, IncrValue) ->
    OldValue = record_mapper:get(Field, Rec),
    record_mapper:set_field(Rec, Field, OldValue + IncrValue).
