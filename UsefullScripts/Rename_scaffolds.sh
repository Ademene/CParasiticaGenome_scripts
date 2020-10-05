awk '/^>/{print ">Scaffold" ++i; next}{print}' < file.fasta > goodname.fasta
