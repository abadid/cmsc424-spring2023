cd ./src
mkdir -p WEB-INF/classes
echo .
javac -classpath WEB-INF/lib/*:WEB_INF/classes -d WEB-INF/classes com/match/model/Field.java com/match/model/Student.java
echo "Built Student.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddStudent.java
echo "Built AddStudent.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddRequest.java
echo "Built AddRequest.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddOffer.java
echo "Built AddOffer.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/ListStudents.java
echo "Built ListStudents.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/SearchStudents.java
echo "Built SearchStudents.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GenerateMatch.java
echo "Built GenerateMatch.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GenerateMatchServlet.java
echo "Built GenerateMatchServlet.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GetAdvisor.java
echo "Built GetAdvisor.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GetAdvisorServlet.java
echo "Built GetAdvisorServlet.java"
jar -cf ROOT.war *.jsp images css js WEB-INF .ebextensions/*.config .ebextensions/*.json
echo .
if [ -d "/opt/tomcat/webapps" ]; then
  cp ROOT.war /opt/tomcat/webapps
  echo "Copied to Tomcat"
fi
mv ROOT.war ../
echo .
echo "SUCCESS"
