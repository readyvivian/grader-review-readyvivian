CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf current-testing
git clone $1 student-submission
echo 'Finished cloning'
if [[ -f student-submission/ListExamples.java ]]
then
    echo 'File detected'
    mkdir current-testing/
    cp student-submission/ListExamples.java current-testing/
    cp TestListExamples.java current-testing/
    cd current-testing
    javac ListExamples.java 2>compilation-result.txt
    if [[ $? -ne 0 ]]
    then
        echo 'Compilation fails'
        exit 1
    else
        echo 'Compilation succeeds'
        javac -cp .:../lib/junit-4.13.2.jar:../lib/hamcrest-2.2.jar:. TestListExamples.java
        java -cp .:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test-result.txt
        if [[ $? -ne 0 ]]
        then
            grep "Tests run:" test-result.txt
            exit 1
        else
            echo 'Correct!'
        fi
    fi
else
    echo 'File not detected'
    exit 1
fi