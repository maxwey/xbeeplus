BUILD_DIR=$(CURDIR)/build
TEST_DIR=$(CURDIR)/test
LIB_DIR=$(CURDIR)/lib

CXX=g++
CXX_FLAGS=-std=c++11 -Wall -Werror -g
#LINK_FLAGS=

all: Libxbee Test1

Libxbee: Utility TransmitRequest ReceivePacket
	$(CXX) -shared -o $(BUILD_DIR)/libxbee_plus.so $(BUILD_DIR)/TransmitRequest.o $(BUILD_DIR)/ReceivePacket.o $(BUILD_DIR)/Utility.o

TransmitRequest:
	$(CXX) $(CXX_FLAGS) -fPIC -c $(LIB_DIR)/TransmitRequest.cpp -o $(BUILD_DIR)/TransmitRequest.o 

ReceivePacket:
	$(CXX) $(CXX_FLAGS) -fPIC -c $(LIB_DIR)/ReceivePacket.cpp -o $(BUILD_DIR)/ReceivePacket.o

Utility:
	$(CXX) $(CXX_FLAGS) -fPIC -c $(LIB_DIR)/Utility.cpp -o $(BUILD_DIR)/Utility.o

Test1: 
	$(CXX) $(CXX_FLAGS) $(TEST_DIR)/main.cpp -o $(BUILD_DIR)/Test1 -lboost_system -lboost_thread -L$(BUILD_DIR) -lxbee_plus
	
.PHONY: clean
	
clean:
	rm $(BUILD_DIR)/*
