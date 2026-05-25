# J2C Rentals

Production-minded car rental platform prototype with a customer storefront and isolated admin operations portal.

## Run Locally

```powershell
C:\Ruby34-x64\bin\ruby.exe bin\rails db:migrate db:seed
C:\Ruby34-x64\bin\ruby.exe bin\rails server -b 127.0.0.1 -p 3000
```

- Customer app: http://127.0.0.1:3000
- Admin portal: http://127.0.0.1:3000/admin-portal

Admin credentials:

- `admin@j2c.test`
- `Admin123!`

See `docs/ARCHITECTURE.md` and `docs/DEPLOYMENT.md`.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
