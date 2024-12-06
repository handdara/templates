#!/usr/bin/env python3

from warnings import warn
import numpy as np
import scipy
import matplotlib.pyplot as plt

import rps.robotarium as rr
import rps.utilities.transformations as rut
import rps.utilities.barrier_certificates as rub
import rps.utilities.misc as rum
import rps.utilities.controllers as ruc


class P4:
    def __init__(self):
        print('init')

    def run_a(self):
        # Instantiate Robotarium object
        N = 5
        initial_conditions = np.array(np.mat('1 0.5 -0.5 0 0.28; 0.8 -0.3 -0.75 0.1 0.34; 0 0 0 0 0'))
        r = rr.Robotarium(number_of_robots=N, show_figure=True, initial_conditions=initial_conditions,sim_in_real_time=True)

        # Define goal points by removing orientation from poses
        goal_points = rum.generate_initial_conditions(N)

        # Create unicycle pose controller
        unicycle_pose_controller = ruc.create_hybrid_unicycle_pose_controller()

        # Create barrier certificates to avoid collision
        uni_barrier_cert = rubcreate_unicycle_barrier_certificate()

        # define x initially
        x = r.get_poses()
        r.step()

        # While the number of robots at the required poses is less
        # than N...
        while (np.size(at_pose(x, goal_points)) != N):

            # Get poses of agents
            x = r.get_poses()

            # Create unicycle control inputs
            dxu = unicycle_pose_controller(x, goal_points)

            # Create safe control inputs (i.e., no collisions)
            dxu = uni_barrier_cert(dxu, x)

            # Set the velocities
            r.set_velocities(np.arange(N), dxu)

            # Iterate the simulation
            r.step()

        #Call at end of script to print debug information and for your script to run on the Robotarium server properly
        r.call_at_scripts_end()

    def run_b(self):
        warn('todo')

    def run(self):
        self.run_a()
        self.run_b()

if __name__ == "__main__":
    print("Hello, World!")
    p4 = P4()
    p4.run()
