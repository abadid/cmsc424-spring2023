cd ./src
mkdir -p WEB-INF/classes
echo .
javac -classpath WEB-INF/lib/*:WEB_INF/classes -d WEB-INF/classes com/match/model/Organ.java com/match/model/Person.java
echo "Built Person.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddPerson.java
echo "Built AddPerson.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddRequest.java
echo "Built AddRequest.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/AddOffer.java
echo "Built AddOffer.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/ListPeople.java
echo "Built ListPeople.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/SearchPeople.java
echo "Built SearchPeople.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GenerateMatch.java
echo "Built GenerateMatch.java"
javac -classpath WEB-INF/lib/*:WEB-INF/classes -d WEB-INF/classes com/match/web/GenerateMatchServlet.java
echo "Built GenerateMatchServlet.java"
jar -cf ROOT.war *.jsp images css js WEB-INF .ebextensions/*.config .ebextensions/*.json
echo .
if [ -d "/opt/tomcat/webapps" ]; then
  cp ROOT.war /opt/tomcat/webapps
  echo "Copied to Tomcat"
fi
mv ROOT.war ../
echo .
echo "SUCCESS"
