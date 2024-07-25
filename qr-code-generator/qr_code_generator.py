data_content = "https://www.example.com"

import qrcode

qr_codes = []
for layer in range(6): 
	qr = qrcode.QRCode(
		version=1,
		error_correction=qrcode.constants.ERROR_CORRECT_L,
		box_size=10,
		border=4,
	)
	qr.add_data(f'{data_content}/layer{layer+1}')
	qr.make(fit=True)
	img = qr.make_image(fill_color="black", back_color="white")
	img.save(f'qr_code_layer{layer+1}.png')
	qr_codes.append(img)
