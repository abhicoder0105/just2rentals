# J2C Rentals Architecture

## Applications

- Customer app: `/`
- Admin operations app: `/admin-portal`
- Admin authentication: `/admin-portal/session/new`

The admin portal is intentionally not linked from the public app. Admin controllers live under `app/controllers/admin`, use `Admin::BaseController`, render the isolated `admin` layout, and require server-side role validation before every protected action.

## Roles

- `customer`: browse fleet, book vehicles, view account, cancel eligible bookings, save favorites.
- `admin`: manage operations, bookings, vehicles, leads, payments, maintenance, support, coupons, and CMS.
- `super_admin`: reserved for platform owner permissions and admin management.

## Security Model

- Passwords use `has_secure_password` with bcrypt.
- Admin access is enforced server-side through `current_user.admin_access?`.
- `/admin` is not routed.
- `/admin-portal` redirects unauthenticated users to the admin-only login.
- Customer sessions and admin sessions use separate controllers.
- Admin pages use a separate layout and stylesheet.
- Admin actions are written to `admin_actions` for audit history.
- Booking conflicts are validated in the model before persistence.

## Core Schema

- `users`: customers, admins, super admins.
- `vehicles`: fleet inventory, pricing, specs, imagery, availability.
- `reservations`: booking lifecycle, invoice, dynamic pricing snapshot, deposits, document review.
- `payments`: payment overview and transaction references.
- `coupons`: pricing controls.
- `rental_documents`: admin document review.
- `maintenance_logs`: fleet service calendar.
- `leads`: sales pipeline.
- `support_tickets`: disputes and customer support.
- `notifications`: future user/admin notifications.
- `reviews`: customer feedback.
- `favorites`: customer wishlist.
- `admin_actions`: audit log.
- `content_blocks`: CMS controls for homepage content.

## Booking Lifecycle

Statuses:

- `pending`
- `approved`
- `active`
- `completed`
- `cancelled`
- `rejected`

Pricing includes daily rate, rental days, protection plan, extras, and coupon discount. The computed details are stored in `pricing_snapshot` for invoice consistency.

## Admin Modules

- Dashboard KPIs: bookings, active rentals, monthly revenue, utilization, pending approvals, overdue returns, maintenance alerts.
- Fleet management: add/edit/delete vehicles.
- Booking operations: approve/reject, review deposits, review documents.
- Lead pipeline: new, contacted, qualified, follow up, managed, lost.
- Payments: transaction and revenue overview.
- Maintenance: service schedule and alerts.
- Customers: CRM overview.
- Support: disputes and tickets.
- Coupons: pricing controls.
- CMS: homepage content blocks.

## Seeded Credentials

- Admin: `admin@j2c.test` / `Admin123!`
- Super admin: `owner@j2c.test` / `Admin123!`
- Customer: `nisha.kapoor@example.com` / `Customer123!`
