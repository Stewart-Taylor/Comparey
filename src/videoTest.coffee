class ImageExtracter

    constructor: () ->

    extractImages: (file, callback) ->
        ffmpegCommand = 'ffmpeg -i ' + file + ' -f image2 -vf fps=fps=1/1 ./testframes/' + file  + '_out%d.png '
        exec = require('child_process').exec
        exec ffmpegCommand, (err, stdout, stderr) ->
            if err?
                console.log("error")
                console.log(stderr)
            else
                callback()



ImageExtracter extracter = new ImageExtracter()


extracter.extractImages "./tbase.mp4", ()->
    console.log("done base")
    extracter.extractImages "./tcompare2.mp4", ()->
        console.log("done new video")
        start()




start = () ->
    i = 0
    while i < 70
        ffmpegCommand = 'compare testframes/tbase.mp4_out' + i + '.png testframes/tcompare2.mp4_out' + i + '.png' + ' -compose src diffframes/diff_' + i + '.png'
        exec = require('child_process').exec
        exec ffmpegCommand, (err, stdout, stderr) ->
            console.log("diff done")
            #if i == 150
        i++
