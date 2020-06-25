## try running these yourself to see how each of functions work

# example 1

for variable in 1 2 3 4 5
do
   echo "Hello $variable times"
done

# ex 2

for variable in {1..5}
do
  echo "Hello $variable times"
done

# ex 3 - the variable can be any name eg/ var, file, i, anything! 

for var in {0..10..2}
  do 
     echo "Hello $var times"
 done
