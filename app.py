from flask import Flask, render_template, request, send_from_directory
app = Flask(__name__)

#import procesatexto as pt

@app.route('/')
def my_form():
	return render_template("my-form.html")
	
@app.route('/', methods=['POST'])
def my_form_post():
	text = request.form['text']
	wav = "sample-20190803-2048.wav" #get_raw_wav(text)
	return render_template(
		'index.html',
		title = 'New Phrase',
		wavfile = wav
	)

@app.route('/music/<path:filename>')
def download_file(filename):
    return send_from_directory('Music', filename)

if __name__ == "__main__":
    app.run(debug=True)
	
	

