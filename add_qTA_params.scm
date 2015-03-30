
(define (add_qTA_params file) 
  (let ((p (load file t)))
    (mapcar
     (lambda (l)
        (set! name (car l))
        (format t "%s UTTS\n" name)
        (set! utt (utt.load nil (format nil "festival/utts/%s.utt" name)))
        (utt.relation.load utt 'qTA (format nil "wav-penta/%s.qTAfest" name))

        (mapcar
          (lambda (x y)
            (begin
              (item.set_feat x 'slope (item.feat y 'slope))
              (item.set_feat x 'height (item.feat y 'height))
              (item.set_feat x 'strength (item.feat y 'strength))
              ))
          (utt.relation.items utt 'Syllable) (utt.relation.items utt 'qTA))
        (utt.save utt (format nil "wav-penta/%s.utt" name))
        t)
     p)
    t))
