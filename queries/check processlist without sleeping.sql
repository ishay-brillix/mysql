select
    *
from
    information_schema.processlist
where
    command != 'Sleep'
    and user != 'system user'
    and user != 'event_scheduler';