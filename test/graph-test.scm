(import chicken scheme test)
(require-extension test)
(load-relative "../graph.scm")
(use graph)
(test-begin "minimum spanning tree")
(test 39 (fold (lambda (y x) (+ x (edge-label y))) 0 (mst
 (digraph->graph
  (alist->digraph
   '((a d 5) (a b 7)
     (b c 8) (b e 7) (b d 9)
     (c e 5)
     (d e 15) (d f 6)
     (e g 9) (e f 8)
     (g f 11))))
 edge-label)))
(test-end "minimum spanning tree")
(test-begin "flyod-warshall")
(test (vector 0 1 1 0)
      (car (floyd-warshall-algorithm
       (digraph->graph
	(alist->digraph
	 '((a d 1))))
       edge-label)))
(test (vector 0 1 +inf.0 0)
      (car (floyd-warshall-algorithm
	(alist->digraph
	 '((a d 1)))
       edge-label)))
(test (vector 0 1 101 +inf.0 0 100 +inf.0 +inf.0 0)
      (car (floyd-warshall-algorithm
	(alist->digraph
	 '((a d 1) (d c 100)))
       edge-label)))
(test (vector -1 1 1 -1 -1 2 -1 -1 -1)
      (cadr (floyd-warshall-algorithm
	(alist->digraph
	 '((a d 1) (d c 100)))
       edge-label)))
(test '(a) 
      (floyd-warshall-extract-path 'a 'a
				   (floyd-warshall-algorithm
				    (alist->digraph
				     '((a d 1) (d c 100)))
				    edge-label)))
(test '(a d) 
      (floyd-warshall-extract-path 'a 'd
				   (floyd-warshall-algorithm
				    (alist->digraph
				     '((a d 1) (d c 100)))
				    edge-label)))
(test '(a d c) 
      (floyd-warshall-extract-path 'a 'c
				   (floyd-warshall-algorithm
				    (alist->digraph
				     '((a d 1) (d c 100)))
				    edge-label)))
(test-end "flyod-warshall")
(test-exit)