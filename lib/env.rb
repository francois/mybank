require "tzinfo"
require "sequel"

TZ = TZInfo::Timezone.get("America/Montreal")
DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
DB.run DB["SET timezone TO ?", TZ.name].sql

NBSP = " " # non-breaking space
