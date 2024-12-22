from flask import Flask, jsonify, request

app = Flask(__name__)

# Пример хранилища подписок
subscriptions = []

@app.route('/subscriptions', methods=['POST'])
def create_subscription():
    data = request.json
    subscription = {
        'id': len(subscriptions) + 1,
        'name': data['name'],
        'amount': data['amount'],
        'frequency': data['frequency'],
        'start_date': data['start_date']
    }
    subscriptions.append(subscription)
    return jsonify(subscription), 201

@app.route('/subscriptions', methods=['GET'])
def get_subscriptions():
    return jsonify(subscriptions), 200

@app.route('/subscriptions/<int:subscription_id>', methods=['PUT'])
def update_subscription(subscription_id):
    data = request.json
    subscription = next((sub for sub in subscriptions if sub['id'] == subscription_id), None)
    if not subscription:
        return jsonify({'error': 'Subscription not found'}), 404
    
    subscription['amount'] = data['amount']
    subscription['frequency'] = data['frequency']
    subscription['start_date'] = data['start_date']
    return jsonify(subscription), 200

@app.route('/subscriptions/<int:subscription_id>', methods=['DELETE'])
def delete_subscription(subscription_id):
    global subscriptions
    subscriptions = [sub for sub in subscriptions if sub['id'] != subscription_id]
    return '', 204

if __name__ == '__main__':
    app.run(port=5000)
