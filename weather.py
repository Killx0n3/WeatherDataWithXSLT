from rdflib import Graph

if __name__ == '__main__':
    g = Graph()

    result = g.parse('http://localhost:8085/weather-2.html', format='rdfa')


    #Query 1: List of all Regions, Locations and Public Districts
    query1 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:region ?obj . }
                    """)

    query1v2 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:location ?obj . }
                    """)

    query1v3 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:public-district ?obj . }
                    """)

    print("Query 1: ")
    print("------------------")
    print("Regions:")
    for x in query1:
        print(x.obj.toPython())

    print("\nLocations:")
    for x in query1v2:
        print(x.obj.toPython())

    print("\nDistricts:")
    for x in query1v3:
        print(x.obj.toPython())


    #Query 2: List of minimum temperatures
    query2 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:min_temp ?obj . }
                    """)

    print("\nQuery 2: ")
    print("------------------")
    print("Min Temps: ")
    for x in query2:
        print(x.obj.toPython()+"°")


    #Query 3: List of maximum temperatures
    query3 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:max_temp ?obj . }
                    """)

    print("\nQuery 3: ")
    print("------------------")
    print("Max Temps: ")
    for x in query3:
        print(x.obj.toPython()+"°")


    #Query 4: List of all forcasted weather conditions
    query3 = g.query("""SELECT ?obj
                        WHERE {<http://localhost:8085/weather-2.html> weather:condition ?obj . }
                    """)

    print("\nQuery 4: ")
    print("------------------")
    for x in query3:
        print("Forcasted condition: ")
        print(x.obj.toPython())