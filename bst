#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;
    Node(int val) {
        data = val;
        left = right = nullptr;
    }
};

// Insert
Node* insert(Node* root, int val) {
    if (root == nullptr) return new Node(val);
    if (val < root->data)
        root->left = insert(root->left, val);
    else if (val > root->data)
        root->right = insert(root->right, val);
    return root;
}

// Search
bool search(Node* root, int key) {
    if (root == nullptr) return false;
    if (root->data == key) return true;
    if (key < root->data)
        return search(root->left, key);
    else
        return search(root->right, key);
}

// Find min value node
Node* findMin(Node* root) {
    while (root->left != nullptr)
        root = root->left;
    return root;
}

// Delete
Node* deleteNode(Node* root, int key) {
    if (root == nullptr) return root;
    if (key < root->data)
        root->left = deleteNode(root->left, key);
    else if (key > root->data)
        root->right = deleteNode(root->right, key);
    else {
        if (root->left == nullptr) {
            Node* temp = root->right;
            delete root;
            return temp;
        } else if (root->right == nullptr) {
            Node* temp = root->left;
            delete root;
            return temp;
        }
        Node* temp = findMin(root->right);
        root->data = temp->data;
        root->right = deleteNode(root->right, temp->data);
    }
    return root;
}

// Inorder Traversal
void inorder(Node* root) {
    if (root) {
        inorder(root->left);
        cout << root->data << " ";
        inorder(root->right);
    }
}

// Main
int main() {
    Node* root = nullptr;
    int keys[] = {50, 30, 20, 40, 70, 60, 80};

    for (int val : keys)
        root = insert(root, val);

    cout << "Inorder after insertion: ";
    inorder(root);
    cout << endl;

    cout << "Search 40: " << (search(root, 40) ? "Found" : "Not Found") << endl;

    root = deleteNode(root, 20);
    cout << "After deleting 20: ";
    inorder(root);
    cout << endl;

    root = deleteNode(root, 30);
    cout << "After deleting 30: ";
    inorder(root);
    cout << endl;

    root = deleteNode(root, 50);
    cout << "After deleting 50: ";
    inorder(root);
    cout << endl;

    return 0;
}
