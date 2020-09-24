require 'faker'

# Super admin

superadmin = User.new(
  email: "admin@itesm.mx",
  password: "admin123",
  role: :superadmin,
  given_name: "Admin",
  institutional_id: "A00000000"
)
superadmin.skip_confirmation!
superadmin.save!

# Lab Admin

lab_admin = User.new(
  email: "labadmin@itesm.mx",
  password: "labadmin",
  role: :lab_admin,
  given_name: "Lab Admin",
  institutional_id: "A02938460"
)
lab_admin.skip_confirmation!
lab_admin.save!

# Lab Admin

lab_space_admin = User.new(
  email: "labspaceadmin@itesm.mx",
  password: "labspaceadmin",
  role: :lab_space_admin,
  given_name: "Lab Space Admin",
  institutional_id: "A02938360"
)

lab_space_admin.skip_confirmation!
lab_space_admin.save!

 ## User

 test_user = User.create!(
   email: "test1@itesm.mx",
   password: "test1234",
   given_name: "Test",
   last_name: "User",
   institutional_id: "A00000001"
 )

 test_user.confirm
 test_user.skip_confirmation!
 test_user.save!

 test_user2 = User.create!(
   email: "test2@itesm.mx",
   password: "test12345",
   given_name: "Test",
   last_name: "User2",
   institutional_id: "A00000002"
 )

 
 test_user2.skip_confirmation!
 test_user2.save!

## Seed capabilities
Capability.create!(name: "Construye")     #0
Capability.create!(name: "Imprimir")      #1
Capability.create!(name: "Cortar")        #3
Capability.create!(name: "Grabar")        #4
Capability.create!(name: "Bordado")       #5


## Seed materials
Material.create!(name: "Madera")          #0
Material.create!(name: "Glass")           #1
Material.create!(name: "ABS")             #2
Material.create!(name: "Ultra-T")         #3
Material.create!(name: "HIPS")            #4
Material.create!(name: "Resina")          #5
Material.create!(name: "Filamento")       #6
Material.create!(name: "Filamento Glass") #7
Material.create!(name: "Triplay 3mm")     #8
Material.create!(name: "Cartón Corrugado")#9
Material.create!(name: "Tela")            #10
Material.create!(name: "Vidrio")          #11
Material.create!(name: "Acrílico")        #12

Capabilities = Capability.ids
Materials = Material.ids

lab = Lab.create!(
  name: "InnovactionGYM",
  description: "El INNOVaction GYM es un gimnasio de innovación y un “makerspace” del Instituto Tecnológico de Monterrey creado con el fin de fomentar la cultura interdisciplinaria de innovación entre los estudiantes, facultad del TEC de Monterrey y la comunidad externa, poniendo a disposición de sus colaboradores un área de 1,100 metros cuadrados de espacio co-work, makerspace, área de juntas, y una área de exposiciones, donde el juego-acción es la base para dar origen a la creación de ideas y proyectos innovadores.",
  location: "CETEC piso 2",
  remote_image_url: "http://lorempixel.com/600/440",
  user_id: lab_admin.id
)

ls = lab.lab_spaces.create!(
  name: "Makers Lab",
  description: "Nuestro interés está enfocado a la creación de una comunidad innovadora capaz de elaborar proyectos de impacto a largo plazo. Por eso, ofrecemos a la comunidad varias oportunidades de colaboración con el fin de generar valor no solamente a nuestra comunidad académica y organizaciones interesadas pero también, a todos stakeholders impactados.",
  hours: "Lunes a Viernes: 8 AM - 5:30 PM",
  location: "Innovaction Gym",
  contact_email: "azael.capetillo@tec.mx",
  contact_phone: "81830020",
  remote_image_url: "http://lorempixel.com/600/440",
  user_id: lab_space_admin.id
)

eq = ls.equipment.create!(
  name: "Escáner 3D Go!Scan",
  description: "Escáner 3D portable, capaz de realizar mediciones rápidas y confiables en 3D y a todo color.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Presición de 0.100 mm, área de escaneo de 143 x 108 mm, fuente de luz blanca y métodos de posición por geometría y/o color y/o objetivo.",
  capability_ids: [],
  material_ids: []
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "8:00 CT",
  end_time: "18:00 CT"
)

eq = ls.equipment.create!(
  name: "Impresora",
  description: "Imprime",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "",
  capability_ids: [Capabilities[0]],
  material_ids: [Materials[0]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:30 CT",
  end_time: "13:00 CT"
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "15:30 CT",
  end_time: "18:00 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D Zotrax M200 - 1",
  description: "Materializa tus diseños 3D de manera fácil y precisa, creando piezas o maquetas volumétricas hechas a partir de tus modelos digitales.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "asdfadfasdfasdf",
  capability_ids: [Capabilities[1]],
  material_ids: [Materials[1],Materials[2],Materials[3],Materials[4],Materials[6]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:00 CT",
  end_time: "22:30 CT"
)

eq.available_hours.create!(
  day_of_week: 4,
  start_time: "8:00 CT",
  end_time: "22:30 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D SLA FormLabs",
  description: "Imprime partes con alta definición en resina.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "",
  capability_ids: [Capabilities[2]],
  material_ids: [Materials[5]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:00 CT",
  end_time: "12:30 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D Rostock 1",
  description: "Materializa tus diseños 3D creando piezas o maquetas volumétricas hechas a partir de tus modelos digitales.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Impresora 3D de modelado por deposición fundida (Fused Deposition Modeling) para filamentos de 1.75mm de diámetro. Cuenta con un área de impresión de base circular de 26cm de diámetro por 38cm de altura. Su extrusor es de 0.5mm. Tiene una resolución de 0.1mm a 0.4mm. Programa de impresión: Cura Ultimaker o Slic3r.",
  capability_ids: [Capabilities[1]],
  material_ids: []
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "9:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "9:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 4,
  start_time: "9:00 CT",
  end_time: "17:00 CT"
)

eq = ls.equipment.create!(
  name: "Impresora Zortrax M-300",
  description: "adfasdf",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "asdfasdf",
  capability_ids: [Capabilities[1]],
  material_ids: [Materials[2], Materials[3], Materials[4]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "9:00 CT",
  end_time: "17:30 CT"
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "9:30 CT",
  end_time: "13:30 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D Rostock Delta Max",
  description: "Materializa tus diseños 3D de manera fácil y precisa, creando piezas o maquetas volumétricas hechas a partir de tus modelos digitales.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Impresora 3D de tecnología layered plastic deposition con volumen de impresión de 300mmx300mmx300mm. Resolución de 90 a 400 micras para filamento de 1.75mm de diámetro y boquilla de 0.4mm de diámetro. Cama caliente. Programa para impresión: Z-Suite.",
  capability_ids: [],
  material_ids: [Materials[2], Materials[4],  Materials[7]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "10:00 CT",
  end_time: "12:00 CT"
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "16:30 CT",
  end_time: "17:30 CT"
)

eq.available_hours.create!(
  day_of_week: 3,
  start_time: "8:00 CT",
  end_time: "17:30 CT"
)

eq = ls.equipment.create!(
  name: "Cortadora láser",
  description: "Graba, corta o marca tus diseño sobre múltiples materiales de forma precisa y rápida.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Cortadora Láser de tubo sellado de CO2 modelo STM-6090, área de trabajo de 60cm X 90cm y potencia de 80 watts.",
  capability_ids: [Capabilities[3], Capabilities[4]],
  material_ids: [Materials[8], Materials[9], Materials[10], Materials[11], Materials[12]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "9:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "9:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 4,
  start_time: "9:00 CT",
  end_time: "14:00 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D",
  description: "Imprime",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Imprime",
  capability_ids: [Capabilities[5]],
  material_ids: [Materials[1], Materials[6], Materials[12]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:00 CT",
  end_time: "13:00 CT"
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "15:30 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "6:00 CT",
  end_time: "8:00 CT"
)

#Mecatronica
lab = Lab.create!(
  name: "Laboratorio de Mecatronica",
  description: "Laboratorio de Mecatronica abierto a todas las carreras, util para crear e inovar.",
  location: "Aulas 7 3er Piso",
  remote_image_url: "http://lorempixel.com/600/440",
  user_id: lab_admin.id
)

ls = lab.lab_spaces.create!(
  name: "Sala de Herramientas",
  description: "Nuestro interés está enfocado a la creación de una comunidad innovadora capaz de elaborar proyectos de impacto a largo plazo. Por eso, ofrecemos a la comunidad varias oportunidades de colaboración con el fin de generar valor no solamente a nuestra comunidad académica y organizaciones interesadas pero también, a todos stakeholders impactados.",
  hours: "Lunes a Sabado 8 AM - 6:00 PM",
  location: "Aulas 7 3er Piso",
  contact_email: "mecatronica@itesm.mx",
  contact_phone: "8111342200",
  remote_image_url: "http://lorempixel.com/600/440",
  user_id: lab_space_admin.id
)

eq = ls.equipment.create!(
  name: "Mecatronica Escaner",
  description: "Escáner 3D portable, capaz de realizar mediciones rápidas y confiables en 3D y a todo color.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Presición de 0.100 mm, área de escaneo de 143 x 108 mm, fuente de luz blanca y métodos de posición por geometría y/o color y/o objetivo.",
  capability_ids: [Capabilities[4]],
  material_ids: [Materials[3]]
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "8:00 CT",
  end_time: "18:00 CT"
)

eq = ls.equipment.create!(
  name: "Impresora 3D 4000 Serie A",
  description: "Materializa tus diseños 3D de manera fácil y precisa, creando piezas o maquetas volumétricas hechas a partir de tus modelos digitales.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Presición de 0.100 mm, área de escaneo de 143 x 108 mm, fuente de luz blanca y métodos de posición por geometría y/o color y/o objetivo.",
  capability_ids: [Capabilities[2]],
  material_ids: [Materials[3], Materials[4]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:00 CT",
  end_time: "22:30 CT"
)

eq.available_hours.create!(
  day_of_week: 4,
  start_time: "8:00 CT",
  end_time: "22:30 CT"
)

eq = ls.equipment.create!(
  name: "Mecatronica Cortadora láser",
  description: "Graba, corta o marca tus diseño sobre múltiples materiales de forma precisa y rápida.",
  remote_image_url: "http://lorempixel.com/600/440",
  technical_description: "Cortadora Láser de tubo sellado de CO2 modelo STM-6090, área de trabajo de 60cm X 90cm y potencia de 80 watts.",
  capability_ids: [Capabilities[3], Capabilities[4]],
  material_ids: [Materials[3], Materials[4], Materials[5]]
)

eq.available_hours.create!(
  day_of_week: 1,
  start_time: "8:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 2,
  start_time: "8:00 CT",
  end_time: "17:00 CT"
)

eq.available_hours.create!(
  day_of_week: 4,
  start_time: "8:00 CT",
  end_time: "14:00 CT"
)

puts "Success! Inserted records into the database"
