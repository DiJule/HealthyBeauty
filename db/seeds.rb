User.destroy_all
User.create!(name: "Admin", email: "admin@demo.com", password: "admin12345", password_confirmation: "admin12345", role: :admin)
Category.destroy_all
Product.destroy_all

makeup = Category.create!(name: "Makeup", image: "https://cdn.britannica.com/35/222035-050-C68AD682/makeup-cosmetics.jpg")
hair = Category.create!(name: "Hair Care", image: "https://www.everescents.com.au/wp-content/uploads/Gallery_FF5-1-e1723181930736.jpg")
skin = Category.create!(name: "Skin Care", image: "https://media.ulta.com/i/ulta/Discover_WK2725_BuyingGuide_ComboSkin?w=600&$background-defaultLight$&fmt=auto")
vitamins = Category.create!(name: "Vitamins", image: "https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/pills-still-life-vitamins-1296x728-header.jpg?w=1155&h=1528")
accessories = Category.create!(name: "Accessories", image: "https://www.shutterstock.com/image-photo/make-products-pink-background-top-600nw-2197448551.jpg")

products = [
  # Makeup
  { name: "Туш для вій Maybelline Lash Sensational", description: "Об'ємна туш для вій з ефектом віяла.", price: 299, stock: 50, category: makeup, image: "https://www.watsons.ua/medias/sys_master/front-prd/front-prd/9331107037214/-Maybelline-New-York-Lash-Sensational-1-1302817.jpg" },
  { name: "Помада L'Oreal Color Riche", description: "Зволожуюча помада з насиченим кольором.", price: 249, stock: 40, category: makeup, image: "https://www.watsons.ua/medias/sys_master/front-prd/front-prd/9331376324638/-COLOR-RICHE-NUDE-INT601-1418191.jpg" },
  { name: "Пудра Max Factor Facefinity", description: "Матуюча компактна пудра для ідеального тону.", price: 320, stock: 30, category: makeup, image: "https://www.watsons.ua/medias/sys_master/front-prd/front-prd/9171920519198/FACEFINITY-COMPACT-040-1358586.jpg" },
  { name: "Палетка тіней NYX Ultimate", description: "Яскраві відтінки для будь-якого макіяжу.", price: 410, stock: 25, category: makeup, image: "https://u.makeup.com.ua/r/rx/rx1qtf0gtpjq.jpg" },
  { name: "Консилер Maybelline Fit Me", description: "Легке маскування недоліків шкіри.", price: 180, stock: 35, category: makeup, image: "https://pwa-api.eva.ua/img/512/512/resize/6/8/686562_10_1749728735.jpg" },
  { name: "Блиск для губ Essence Shine", description: "Сяючий блиск для губ з доглядом.", price: 95, stock: 60, category: makeup, image: "https://www.watsons.ua/medias/sys_master/front-prd/front-prd/9288067776542/-EXTREME-SHINE-02-1393726.jpg" },

  # Hair Care
  { name: "Шампунь Head & Shoulders Classic", description: "Проти лупи, для щоденного використання.", price: 150, stock: 60, category: hair, image: "https://media.prostor.ua/catalog/product/1/8/185381.png?store=ru&image-type=image" },
  { name: "Бальзам Gliss Kur Ultimate Repair", description: "Відновлення пошкодженого волосся.", price: 180, stock: 45, category: hair, image: "https://pwa-api.eva.ua/img/512/512/resize/3/6/366415_1_1728052042.jpg" },
  { name: "Олія для волосся Garnier Fructis", description: "Живлення та блиск для всіх типів волосся.", price: 210, stock: 35, category: hair, image: "https://pwa-api.eva.ua/img/512/512/resize/3/8/383643_1_1715953686.jpg" },
  { name: "Спрей для укладки Taft Power", description: "Сильна фіксація без склеювання.", price: 120, stock: 50, category: hair, image: "https://images.pexels.com/photos/5240272/pexels-photo-5240272.jpeg?cs=srgb&dl=pexels-karolina-grabowska-5240272.jpg&fm=jpg" },
  { name: "Маска для волосся Pantene Pro-V", description: "Глибоке відновлення та живлення.", price: 230, stock: 30, category: hair, image: "https://pwa-api.eva.ua/img/512/512/resize/7/1/719615_1_1757416737.jpg" },
  { name: "Гребінець Tangle Teezer", description: "Для легкого розчісування без болю.", price: 250, stock: 40, category: accessories, image: "https://stylesalon.com.ua/images/detailed/150/rascheska-tangle-teezer-the-wet-detangler-mini.jpg" },

  # Skin Care
  { name: "Крем для обличчя Nivea Soft", description: "Легка зволожуюча формула для щоденного догляду.", price: 110, stock: 70, category: skin, image: "https://pwa-api.eva.ua/img/512/512/resize/1/9/199089_1_1740491769.jpg" },
  { name: "Гель для вмивання La Roche-Posay", description: "Очищення для чутливої шкіри.", price: 340, stock: 30, category: skin, image: "https://u.makeup.com.ua/s/so/soqhrsimukk0.jpg" },
  { name: "Сироватка L'Oreal Revitalift", description: "Антивікова сироватка з гіалуроновою кислотою.", price: 520, stock: 20, category: skin, image: "https://u.makeup.com.ua/i/it/it7xzkagwxvr.jpg" },
  { name: "Маска для обличчя Garnier Hydra Bomb", description: "Інтенсивне зволоження за 15 хвилин.", price: 65, stock: 80, category: skin, image: "https://pwa-api.eva.ua/img/0/0/resize/4/3/431849_1_1757066395.jpg" },
  { name: "Тонік Bioderma Sensibio", description: "Заспокійливий тонік для чутливої шкіри.", price: 210, stock: 25, category: skin, image: "https://pwa-api.eva.ua/img/0/0/resize/1/0/1066863_1_1740989829.jpg" },

  # Vitamins
  { name: "Вітамін C Solgar 500mg", description: "Підтримка імунітету, 100 таблеток.", price: 390, stock: 25, category: vitamins, image: "https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/sol/sol03260/l/121.jpg" },
  { name: "Комплекс вітамінів Supradyn", description: "Для енергії та життєвого тонусу.", price: 270, stock: 40, category: vitamins, image: "https://www.supradyn.ua/sites/g/files/vrxlpx37371/files/styles/desktop_1000xauto/public/2022-08/packshot%2Bicon_kids_main_page_new.png?itok=tSIlryui" },
  { name: "Омега-3 Doppelherz", description: "Для серця та судин, 60 капсул.", price: 310, stock: 30, category: vitamins, image: "https://med-magazin.ua/media/205/2053104-doppel-gertc-aktiv-doppel-herz-aktiv-omega-3-30-10h3.jpg" },
  { name: "Вітамін D3 Now Foods", description: "Підтримка кісток та імунітету.", price: 220, stock: 35, category: vitamins, image: "https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00373/y/106.jpg" },
  { name: "Магній B6", description: "Для нервової системи та м'язів.", price: 180, stock: 20, category: vitamins, image: "https://robinia-pharm.com/image/data/products/bez-recepta/vitamin/magnez/magne-b6-50.jpg" },
  { name: "Animal Flex", description: "Animal Flex® — це високоефективна формула для підтримки суглобів, розроблена спеціально для того, щоб ви могли розширити свої межі та досягти нових віх у своїй фітнес або спортивній діяльності. Водночас піклується про основні опорні структури — суглоби, кістки та зв’язки — і підтримує їхню міцність.", price: 1550, stock: 15, category: vitamins, image: "https://powerlife.com.ua/files/products/60f57da5-7eb1-11e8-a232-bf0ccfd5046f_d68b5f9e-e166-11ef-a31f-a7c3b8591a4e.800x600w.jpg" },

  # Accessories
  { name: "Косметичка Oriflame", description: "Зручна та стильна для зберігання косметики.", price: 180, stock: 50, category: accessories, image: "https://media-cdn.oriflame.com/productImage?externalMediaId=product-management-media%2FProducts%2F47821%2F47821_1.png&MediaId=19732150&Version=3&w=600&bc=%23f5f5f5&ib=%23f5f5f5&h=600&q=90&imageFormat=WebP" },
  { name: "Дзеркальце компактне Avon", description: "Компактне дзеркальце для сумочки.", price: 90, stock: 60, category: accessories, image: "https://image-thumbs.shafastatic.net/-47917992_310_430" },
  { name: "Пензлі для макіяжу Real Techniques", description: "Набір для ідеального макіяжу.", price: 420, stock: 20, category: accessories, image: "https://u.makeup.com.ua/4/4d/4dkfxenmmlfl.jpg" },
  { name: "Резинки для волосся Invisibobble", description: "Не залишають слідів на волоссі.", price: 70, stock: 100, category: accessories, image: "https://u.makeup.com.ua/f/f9/f95kcxafkn7e.jpg" }
]

products.each { |prod| Product.create!(prod) }

puts "Categories and products created!"
