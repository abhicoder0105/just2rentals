AdminAction.destroy_all
UserPermission.destroy_all
Permission.destroy_all
AdminInvitation.destroy_all
Notification.destroy_all
SupportTicket.destroy_all
Review.destroy_all
Favorite.destroy_all
Payment.destroy_all
MaintenanceLog.destroy_all
ContentBlock.destroy_all
Coupon.destroy_all
Lead.destroy_all
Vehicle.destroy_all
User.destroy_all

admin = User.create!(
  name: "Operations Admin",
  email: "admin@j2c.test",
  phone: "+91 99999 00001",
  role: "admin",
  password: "Admin123!",
  password_confirmation: "Admin123!"
)

super_admin = User.create!(
  name: "Platform Owner",
  email: "owner@j2c.test",
  phone: "+91 99999 00002",
  role: "super_admin",
  password: "Admin123!",
  password_confirmation: "Admin123!"
)

fleet_manager = User.create!(
  name: "Fleet Manager",
  email: "fleet@j2c.test",
  phone: "+91 99999 00003",
  role: "fleet_manager",
  password: "Admin123!",
  password_confirmation: "Admin123!"
)

support_agent = User.create!(
  name: "Support Agent",
  email: "support@j2c.test",
  phone: "+91 99999 00004",
  role: "support_agent",
  password: "Admin123!",
  password_confirmation: "Admin123!"
)

customer = User.create!(
  name: "Nisha Kapoor",
  email: "nisha.kapoor@example.com",
  phone: "+91 98765 11111",
  role: "customer",
  password: "Customer123!",
  password_confirmation: "Customer123!"
)

second_customer = User.create!(
  name: "Rahul Bansal",
  email: "rahul.bansal@example.com",
  phone: "+91 98765 22222",
  role: "customer",
  password: "Customer123!",
  password_confirmation: "Customer123!"
)

vehicles = [
  {
    name: "Urban Swift",
    make: "Maruti Suzuki",
    model: "Swift",
    year: 2025,
    category: "Economy",
    seats: 5,
    doors: 4,
    transmission: "Manual",
    fuel: "Petrol",
    drivetrain: "FWD",
    location: "Delhi Airport",
    daily_rate: 2199,
    rating: 4.6,
    image_url: "https://images.unsplash.com/photo-1542362567-b07e54358753?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#0f766e",
    mileage: "20 km/l",
    luggage: 2,
    featured: true,
    description: "A nimble city hatchback for airport pickups, local meetings, and quick weekend movement."
  },
  {
    name: "Cityline i20",
    make: "Hyundai",
    model: "i20",
    year: 2025,
    category: "Compact",
    seats: 5,
    doors: 4,
    transmission: "Automatic",
    fuel: "Petrol",
    drivetrain: "FWD",
    location: "Gurugram Cyber City",
    daily_rate: 2899,
    rating: 4.7,
    image_url: "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#be123c",
    mileage: "18 km/l",
    luggage: 2,
    featured: false,
    description: "Comfortable, compact, and easy to park near business districts and hotels."
  },
  {
    name: "Creta Trail",
    make: "Hyundai",
    model: "Creta",
    year: 2026,
    category: "SUV",
    seats: 5,
    doors: 4,
    transmission: "Automatic",
    fuel: "Diesel",
    drivetrain: "FWD",
    location: "Mumbai Airport",
    daily_rate: 4499,
    rating: 4.8,
    image_url: "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#1d4ed8",
    mileage: "17 km/l",
    luggage: 4,
    featured: true,
    description: "A high-clearance SUV with generous luggage space for airport runs and coastal drives."
  },
  {
    name: "Innova Executive",
    make: "Toyota",
    model: "Innova Hycross",
    year: 2026,
    category: "Van",
    seats: 7,
    doors: 4,
    transmission: "Automatic",
    fuel: "Hybrid",
    drivetrain: "FWD",
    location: "Bengaluru Indiranagar",
    daily_rate: 5799,
    rating: 4.9,
    image_url: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#7c3aed",
    mileage: "21 km/l",
    luggage: 5,
    featured: true,
    description: "A premium people-mover for families, teams, and long in-city itineraries."
  },
  {
    name: "Coastal Thar",
    make: "Mahindra",
    model: "Thar",
    year: 2025,
    category: "SUV",
    seats: 4,
    doors: 3,
    transmission: "Automatic",
    fuel: "Diesel",
    drivetrain: "4WD",
    location: "Goa Panaji",
    daily_rate: 5199,
    rating: 4.8,
    image_url: "https://images.unsplash.com/photo-1609521263047-f8f205293f24?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#b45309",
    mileage: "15 km/l",
    luggage: 2,
    featured: true,
    description: "Open-road character with 4WD confidence for scenic drives and resort transfers."
  },
  {
    name: "Model 3 Volt",
    make: "Tesla",
    model: "Model 3",
    year: 2026,
    category: "Electric",
    seats: 5,
    doors: 4,
    transmission: "Automatic",
    fuel: "Electric",
    drivetrain: "RWD",
    location: "Delhi Airport",
    daily_rate: 6999,
    rating: 4.9,
    image_url: "https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#0891b2",
    mileage: "520 km range",
    luggage: 3,
    featured: false,
    description: "A quiet electric sedan for premium arrivals, low running cost, and smooth highway cruising."
  },
  {
    name: "Camry Signature",
    make: "Toyota",
    model: "Camry",
    year: 2026,
    category: "Luxury",
    seats: 5,
    doors: 4,
    transmission: "Automatic",
    fuel: "Hybrid",
    drivetrain: "FWD",
    location: "Mumbai Airport",
    daily_rate: 6299,
    rating: 4.8,
    image_url: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#334155",
    mileage: "23 km/l",
    luggage: 3,
    featured: false,
    description: "A refined sedan for business travel, hotel transfers, and comfortable long drives."
  },
  {
    name: "Kwid Easy",
    make: "Renault",
    model: "Kwid",
    year: 2024,
    category: "Economy",
    seats: 5,
    doors: 4,
    transmission: "Manual",
    fuel: "Petrol",
    drivetrain: "FWD",
    location: "Goa Panaji",
    daily_rate: 1799,
    rating: 4.4,
    image_url: "https://images.unsplash.com/photo-1580273916550-e323be2ae537?auto=format&fit=crop&w=1200&q=80",
    hero_color: "#16a34a",
    mileage: "22 km/l",
    luggage: 2,
    featured: false,
    description: "A budget-friendly city car for short hops, errands, and flexible sightseeing days."
  }
]

created_vehicles = Vehicle.create!(vehicles)

permissions = [
  ["fleet.manage", "Add, edit, and remove vehicles", "Fleet"],
  ["bookings.manage", "Approve, reject, and operate bookings", "Bookings"],
  ["payments.view", "View payment and deposit analytics", "Finance"],
  ["maintenance.manage", "Schedule and update vehicle maintenance", "Fleet"],
  ["support.manage", "Handle support tickets and disputes", "Support"],
  ["pricing.manage", "Manage coupons and pricing controls", "Pricing"],
  ["cms.manage", "Manage homepage and marketing content", "Content"],
  ["team.manage", "Invite admins and assign permissions", "Security"]
].map do |key, description, category|
  Permission.create!(key: key, description: description, category: category)
end

admin.permissions = permissions
super_admin.permissions = permissions
fleet_manager.permissions = Permission.where(key: ["fleet.manage", "maintenance.manage"])
support_agent.permissions = Permission.where(key: ["support.manage", "bookings.manage"])

AdminInvitation.create!(
  email: "future.ops@example.com",
  role: "support_agent",
  invited_by: super_admin,
  expires_at: 7.days.from_now
)

coupon = Coupon.create!(
  code: "WEEKEND15",
  description: "Weekend demand promotion for approved customers.",
  discount_type: "percent",
  value: 15,
  starts_on: Date.current - 2.days,
  ends_on: Date.current + 45.days,
  usage_limit: 100
)

reservations = [
  {
    vehicle: created_vehicles.third,
    user: customer,
    coupon: coupon,
    first_name: "Nisha",
    last_name: "Kapoor",
    email: "nisha.kapoor@example.com",
    phone: "+91 98765 11111",
    pickup_location: "Mumbai Airport",
    dropoff_location: "Mumbai Airport",
    pickup_date: Date.current + 2.days,
    dropoff_date: Date.current + 5.days,
    pickup_time: "09:30",
    dropoff_time: "18:00",
    driver_age: 31,
    protection_plan: "Premium",
    extras: ["Airport fast pickup", "Additional driver"],
    status: "pending",
    deposit_amount: 4499,
    deposit_status: "Paid",
    document_status: "Pending review",
    admin_notes: "Corporate traveler. Verify license before handover."
  },
  {
    vehicle: created_vehicles.fourth,
    user: second_customer,
    first_name: "Rahul",
    last_name: "Bansal",
    email: "rahul.bansal@example.com",
    phone: "+91 98765 22222",
    pickup_location: "Bengaluru Indiranagar",
    dropoff_location: "Gurugram Cyber City",
    pickup_date: Date.current + 7.days,
    dropoff_date: Date.current + 11.days,
    pickup_time: "11:00",
    dropoff_time: "16:30",
    driver_age: 39,
    protection_plan: "Plus",
    extras: ["Child seat", "Unlimited kilometers"],
    status: "approved",
    deposit_amount: 5799,
    deposit_status: "Paid",
    document_status: "Accepted",
    reviewed_by: admin.name,
    reviewed_at: Time.current
  }
]

created_reservations = Reservation.create!(reservations)

created_reservations.first.rental_documents.create!([
  { document_type: "Driving license", file_name: "nisha-license.pdf", status: "Pending review", notes: "Front side received." },
  { document_type: "Aadhaar / ID proof", file_name: "nisha-id.pdf", status: "Accepted", notes: "Matches booking name." }
])

created_reservations.second.rental_documents.create!([
  { document_type: "Driving license", file_name: "rahul-license.pdf", status: "Accepted", notes: "Valid through next year." },
  { document_type: "Payment receipt", file_name: "rahul-deposit.pdf", status: "Accepted", notes: "Deposit captured." }
])

Payment.create!([
  {
    reservation: created_reservations.first,
    user: customer,
    amount: 4499,
    status: "Paid",
    provider: "Demo Gateway",
    transaction_id: "PAY#{SecureRandom.alphanumeric(8).upcase}",
    paid_at: Time.current - 2.hours
  },
  {
    reservation: created_reservations.second,
    user: second_customer,
    amount: 5799,
    status: "Paid",
    provider: "Demo Gateway",
    transaction_id: "PAY#{SecureRandom.alphanumeric(8).upcase}",
    paid_at: Time.current - 1.day
  }
])

MaintenanceLog.create!([
  { vehicle: created_vehicles.third, status: "Scheduled", service_type: "Tire inspection", scheduled_on: Date.current + 3.days, cost: 2400, odometer: 18_200, notes: "Before next long rental." },
  { vehicle: created_vehicles.fifth, status: "Overdue", service_type: "Brake check", scheduled_on: Date.current - 1.day, cost: 5200, odometer: 22_900, notes: "Block if not completed today." }
])

SupportTicket.create!(
  user: customer,
  reservation: created_reservations.first,
  subject: "Need invoice GST details",
  category: "Billing",
  priority: "Medium",
  status: "Open",
  message: "Customer requested invoice update before pickup."
)

ContentBlock.create!(
  key: "homepage-summer-drive",
  title: "Summer highway-ready rentals",
  body: "Promote airport-ready SUVs, family vans, and electric sedans for premium self-drive bookings.",
  image_url: "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&w=1600&q=80",
  placement: "homepage",
  active: true
)

AdminAction.create!(
  user: admin,
  action: "seed.initialized",
  resource_type: "System",
  ip_address: "127.0.0.1",
  metadata: { note: "Seed data created" }.to_json
)

Lead.create!([
  {
    name: "Ananya Rao",
    email: "ananya.rao@example.com",
    phone: "+91 90000 11111",
    trip_location: "Goa Panaji",
    preferred_vehicle: "SUV convertible feel",
    source: "Website",
    status: "New",
    priority: "High",
    follow_up_on: Date.current + 1.day,
    budget: 6000,
    notes: "Wants a scenic weekend rental and airport pickup."
  },
  {
    name: "Vikram Sethi",
    email: "vikram.sethi@example.com",
    phone: "+91 90000 22222",
    trip_location: "Delhi Airport",
    preferred_vehicle: "Electric sedan",
    source: "WhatsApp",
    status: "Contacted",
    priority: "Medium",
    follow_up_on: Date.current + 2.days,
    budget: 7500,
    notes: "Asked about charging support and included kilometers."
  },
  {
    name: "Meera Iyer",
    email: "meera.iyer@example.com",
    phone: "+91 90000 33333",
    trip_location: "Bengaluru Indiranagar",
    preferred_vehicle: "7-seater",
    source: "Referral",
    status: "Managed",
    priority: "Urgent",
    follow_up_on: Date.current,
    budget: 6500,
    notes: "Converted to approved reservation."
  },
  {
    name: "Kabir Khan",
    phone: "+91 90000 44444",
    trip_location: "Mumbai Airport",
    preferred_vehicle: "Luxury sedan",
    source: "Campaign",
    status: "Lost",
    priority: "Low",
    follow_up_on: Date.current - 1.day,
    budget: 3000,
    notes: "Budget mismatch."
  }
])
