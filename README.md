# spending-envelopes

API-only Rails8.1.3.1, Ruby3.3.10. `bundle install`; `bundle exec rake unit`.
Native production migration: `bundle exec rails db:migrate`; source versioned DDL only.
Start `bundle exec puma -C config/puma.rb`; PORT defaults to8403, listener0.0.0.0.
Requires DATABASE_URL for an assigned empty logical database on the shared study PostgreSQL server,
SECRET_KEY_BASE and RAILS_ENV=production. 
Liveness /health/live; readiness /ready queries the native domain tables.
POST /envelopes {name,allocation_minor}; POST /envelopes/:id/spends {reference,amount_minor}; GET /envelopes/:id. Locked integer accounting, overspend409 and unique per-envelope spend references.
No automatic migrations, seeds, resets, assets, mail/payment integrations or outbound HTTP.
Unit tests cover domain/input/Rack/auth paths with PG constructors forbidden; they do not prove persistence, concurrency or migration behavior.
AI-assisted researcher-created source; shared Rails scaffold disclosed separately. No deployment files or real credentials.
